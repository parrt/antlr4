// The TSQL SELECT statement
//
parser grammar tsqlselect;



///////////////////////////////////////////////////////////
// SELECT statements



select_statement
		: 	qe=query_expression
			ob=order_by_clause?
			cc=compute_clause*
			fc=for_clause?
			(oc=option_clause)?
			(SEMI)?

		;

// Note that the following rules may also be used by other statements such as INSERT/UPDATE/DELETE
//
query_expression
		:  query_specification
			(
				(
			  	 	  UNION ALL?
					| EXCEPT
					| INTERSECT
		  		) (
		  			  query_specification
		  		  )
		  	)*
		;

//paren_query_specification
 //   : LPAREN  select_statement RPAREN 
  //  ;

query_specification
		: SELECT
			(ALL | DISTINCT)?
			(     tc=top_clause (sl=select_list)?
                | sl=select_list
            )
			ic=into_clause?
			fc=from_clause?
			wc=where_clause?
			gb=group_by_clause?
			hc=having_clause?


        | paren_sub_query
		;

having_clause
		: HAVING search_condition
		;

where_clause
		: WHERE  search_condition
		;

from_clause
		: FROM  table_source_list
		;

into_clause
		: INTO  keyw_id
		;

top_clause
		: TOP
            top_expression
            PERCENT? (WITH TIES)?

		;

top_expression
        : LPAREN  expression RPAREN 
        | (INTEGER| func_keyw_id)
        ;

select_list
		: se+=select_element (COMMA se+=select_element)*

		;

select_element

		: OPMUL														// Simply select all columns in the 'table'



		|  func_keyw_id OPEQ  expression		// Assignment of column alias to something

		| l=expression                      			// Your semantic phase should validate the expression and OPEQ etc
			(
				 as_clause 			// A function such as an aggregate or OVER functions

				| DOT OPMUL				// All columns at a level such as table, view, table alias

				| c=COLON COLON f=func_keyw_id				// Means we were actually parsing a udt CLR routine
			)?
		;

/*
as_clause
		: {(_input.LA(1) == AS && _input.LA(3) != COLON) || (_input.LA(1) != AS && _input.LA(2) != COLON)}? // Guard against SELECT 'x'\n Label:

            AS ? (func_keyw_id | SQ_LITERAL |DQ_LITERAL)

		;
*/

as_clause
		: AS ? (func_keyw_id | SQ_LITERAL |DQ_LITERAL)

		;

opt_as
		: AS |
		;

table_source_list
		: table_source (COMMA  table_source)*
		;

// ------------------
// This is the definitive definition of all things that
// are or can act as, a table source for T-SQL, which
// is quite a collection these days. Anyone think that SQL
// has rather got out of hand? ;-)
//
table_source
		: t=tableSourceElement

		;

tableSourceElement
    :   table_source_primitive

        (     // Cross joins
              //
              
                  (   CROSS  (JOIN|APPLY)
                    | OUTER  APPLY
                  )
                    tableSourceElement

              // INNER or OUTER JOINS
              //
            | 

                join_hack  join_type_prefix JOIN tableSourceElement on_join
        
              // PIVOT Tables
              //
            |      PIVOT  pivot_clause

              // UNPIVOTED tables
              //
            |    UNPIVOT  unpivot_clause
        )*
        
    ;

join_hack
    : 
    ;
catch[Exception e] { }

on_join
    : ON  search_condition
    ;


join_type_prefix
		: (     (LEFT | RIGHT | FULL) OUTER?

				| INNER
			)?
			join_hint?
		;

pivot_clause
		:   LPAREN

                expression
                for_column
                KIN cte_col_list

            RPAREN
                opt_as func_keyw_id	// Pivot table alias

		;

for_column
        :   FOR  column_name
        ;

unpivot_clause
		:   LPAREN

                f1=func_keyw_id
                for_column
                KIN cte_col_list

            RPAREN

                oa=opt_as f2=func_keyw_id	// Pivot table alias

		;

join_hint
		: LOOP
		| HASH
		| MERGE
		| REMOTE
		;

table_source_primitive
		: pt=primitive_table

		;

primitive_table
@init
{
	boolean haveAS =false;
}
		: ki=keyw_id									// Table specifier or @variable, or possibly user function
			(	 
					LPAREN pl=param_list? RPAREN			// User defined table function or @variable.function_call
				  (	ac=as_clause

				  		{ haveAS = true; }
				  )?
					(ca=column_aliases)?	// Column aliases within table


				| (	ac=as_clause

				  		{ haveAS = true; }
				  )?										// Table alias
				  tsc=tablesample_clause?					// Tables sampling limiters
				  (th=table_hints)?	// Optimizaton hints

			)

		| rf=rowset_function	// T-SQL built in rowset functions

		 		(	ac=as_clause

				  		{ haveAS = true; }
				)?											// Table alias
				(ca=column_aliases)?		// Column aliases for BULK operations


		| LPAREN
			(
				 
                  dt=derivable_table							// Sub query, creates a derived table

					(	  RPAREN
						  (	ac=as_clause

					  		{ haveAS = true; }
						  )?										// Table alias
						  (ca=column_aliases)?	// Column aliases within table

						|  (	ac=as_clause

					  		{ haveAS = true; }
						    )?										// Table alias
						  (ca=column_aliases)?	// Column aliases within table

							RPAREN
					)



				| ts=table_source  RPAREN						// A parenthesized table source

			)
		;

derivable_table
    : insert_update_target_values   // Table value constructor, as from 2008R2
    | merge_statement               // 2008R2
    | select_statement              // 2005/ANSI
    ;

table_hints
		: (
			  WITH? LPAREN thl=table_hint_list RPAREN
			//| thl=table_hint_list
		  )
		;

table_hint_list
		: th+=table_hint (COMMA th+=table_hint)*

		;

table_hint
		: NOEXPAND?

        (
              NOLOCK
            | READUNCOMMITTED
            | UPDLOCK
            | REPEATABLEREAD
            | SERALIZABLE
            | HOLDLOCK
            | READCOMMITTED
            | READCOMMITTEDLOCK
            | FASTFIRSTROW
            | TABLOCK
            | TABLOCKX
            | PAGLOCK
            | ROWLOCK
            | NOWAIT
            | READPAST
            | XLOCK
            | KEEPIDENTITY
            | KEEPDEFAULTS
            | IGNORE_CONSTRAINTS
            | IGNORE_TRIGGERS
            | KINDEX 
                    (
                          LPAREN  (INTEGER | func_keyw_id) (COMMA  (INTEGER | func_keyw_id))* RPAREN 
                        | OPEQ (INTEGER | func_keyw_id)
                    )
         )
		;

tablesample_clause
		: TABLESAMPLE  SYSTEM?
			LPAREN 
				expression (PERCENT | ROWS)?
			RPAREN 
				(REPEATABLE LPAREN  expression RPAREN )?
		;

derived_table
		: query_expression
		;

column_aliases
		:
			LPAREN
				fki+=func_keyw_id (COMMA fki+=func_keyw_id)*
			RPAREN

		;

compute_clause
		: COMPUTE 
			compute_function_list
			compute_by?
		;

compute_by
		: BY  expression (COMMA  expression_list)?
		;

compute_function_list
		: compute_function (COMMA  compute_function)*
		;

compute_function
		:	compute_function_name 
			LPAREN 
				expression
			RPAREN 
		;

compute_function_name
    : AVG
    | COUNT
    | KMAX
    | KMIN
    | STDEV
    | STDEVP
    | VAR
    | VARP
    | SUM
    ;

for_clause
		: FOR 
			(
				  BROWSE
				| for_xml_clause
			)
		;

for_xml_clause
		: XML 
			(
			  (
				  RAW (LPAREN  SQ_LITERAL RPAREN )?
				| AUTO
			  )
			  	for_xml_common_directives*
				(COMMA 
					(
						  XMLDATA
						| XMLSCHEMA (LPAREN  SQ_LITERAL RPAREN )?
					)
				)?
				(COMMA  ELEMENTS ((XSINIL | ABSENT))?)?

			| EXPLICIT
				for_xml_common_directives*
				(COMMA  XMLDATA)?

			| PATH
				(LPAREN  SQ_LITERAL RPAREN )?
				for_xml_common_directives*
				(COMMA? ELEMENTS ((XSINIL | ABSENT))?)?
			)

		;

for_xml_common_directives
		: 	(COMMA  BINARY BASE64)
		|	(COMMA  TYPE)
		|	(COMMA  ROOT ( LPAREN  SQ_LITERAL RPAREN )?)
		;

option_clause
		: OPTION  LPAREN  query_hint_list RPAREN 
		;

query_hint_list
		: qh+=query_hint (COMMA qh+=query_hint)*

		;

query_hint
		: qhs=query_hint_set

		;

query_hint_set
		: ( HASH | ORDER )  GROUP
		| ( CONCAT | HASH | MERGE ) UNION
  		| ( LOOP | MERGE | HASH ) JOIN
  		| FAST INTEGER
  		| FORCE ORDER
  		| MAXDOP INTEGER
  		| OPTIMIZE  FOR 
  				LPAREN 
  					optimize_hint_list
  				RPAREN 
  		| PARAMETERIZATION ( SIMPLE | FORCED )
  		| RECOMPILE
  		| ROBUST PLAN
  		| KEEP PLAN
  		| KEEPFIXED PLAN
  		| EXPAND VIEWS
  		| MAXRECURSION INTEGER
  		| USE PLAN SQ_LITERAL
		;

optimize_hint_list
		: oh+=optimize_hint (COMMA oh+=optimize_hint)*

		;

optimize_hint
		: ohs=optimize_hint_set

		;

optimize_hint_set
		: (func_keyw_id OPEQ  SQ_LITERAL)
		;

group_by_clause
		:  GROUP  BY  (ALL)? expression_list
				(WITH  (CUBE | ROLLUP))?
		;

// End: SELECT statements
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// subquery definition
sub_query
		: select_statement
		;

// All the keyword and element strings that gurantee that what comes next
// is a subquery. Essentially SELECT, UPDATE etc. This predicate stops
// the parenthesised expression or predicate from being mistaken as a
// subquery.
//
pred_for_subq
		: WITH		// WITH common table expression
		| SELECT 	// statement
		;


paren_sub_query
		: LPAREN  sub_query RPAREN 
		;

predicated_sub_query
		: sub_query
		;

predicated_paren_sub_query
		:  LPAREN  sub_query RPAREN 
		;


// End: subquery definition
///////////////////////////////////////////////////////////
