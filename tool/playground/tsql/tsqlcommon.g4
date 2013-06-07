/**
 * This parser covers all grammar fragments that are common among two or more rules
 * and can be reused in the interests of efficiency. Constructs like AUTHORIZATION
 * and EXTERNAL are specified here and referred to in the main grammar and the
 * import grammars.
 */
parser grammar tsqlcommon;


// General common constructs
//
external_name
    : EXTERNAL  NAME  keyw_id
    ;

common_returns
    : RETURNS  expression
    ;

common_return
    : RETURN  ( expression)?
    ;

common_data_type_name
    : keyw_id
    | CURSOR
    ;
authorization
	: AUTHORIZATION  keyw_id
	;



opt_into
    : INTO
    | 
    ;

table_hint_limited_list
    : t+=table_hint_limited+

    ;

table_hint_limited
		: KEEPIDENTITY      | KEEPDEFAULTS      | FASTFIRSTROW
        | HOLDLOCK          | IGNORE_CONSTANTS  | IGNORE_TRIGGERS
        | NOWAIT            | PAGLOCK           | READCOMMITTED
        | READCOMMITTEDLOCK | READPAST          | REPEATABLEREAD
        | ROWLOCK           | SERIALIZABLE      | TABLOCK
        | TABLOCKX          | UPDLOCK            | XLOCK
		;

common_top_clause
    :  TOP LPAREN expression RPAREN PERCENT?

    ;

common_with_hints
    : WITH  LPAREN  table_hint_limited_list RPAREN 
    ;
    
output_clause
    : output_dml

        (
              INTO  keyw_id (LPAREN  keyw_id_list RPAREN )?

              output_dml?
        )?
    ;

output_dml
    : OUTPUT  dml_select_list
    ;

dml_select_list
    : d+=dml_select (COMMA d+=dml_select)*

    ;

dml_select
    : del_col_name (opt_as  keyw_id)?
    ;

del_col_name
    : expression (DOT  OPMUL )?
    | ACTION
    ;

// Assembly common
//
common_set_item_list
	: si+=common_set_item (COMMA si+=common_set_item)*

	;

common_set_item
	: NAME  OPEQ  keyw_id
	| PASSWORD  OPEQ  SQ_LITERAL
	| DEFAULT_SCHEMA  OPEQ  keyw_id
	;

assembly_from
	: FROM  expression
	;

assembly_with
	: WITH assembly_option_list

	;

assembly_option_list
	: assembly_option (COMMA  assembly_option)*
	;

assembly_option
	: PERMISSION_SET  OPEQ  ( SAFE | EXTERNAL_ACCESS | UNSAFE)
	| VISIBILITY  OPEQ  (ON | OFF)
	| UNCHECKED  DATA
	;

assembly_name
	: keyw_id
	;

// Assymetric key common
//
ak_password_option
	: ENCRYPTION  BY  PASSWORD  OPEQ  SQ_LITERAL
			( COMMA ? DECRYPTION  BY  PASSWORD  OPEQ  SQ_LITERAL )?
	| DECRYPTION  BY  PASSWORD  OPEQ  SQ_LITERAL ( COMMA ? ENCRYPTION  BY  PASSWORD  OPEQ  SQ_LITERAL )?
	;

// Certificate common
//
private_key_list
	: private_key_spec (COMMA  private_key_spec)*
	;

private_key_spec
	: KFILE  OPEQ  SQ_LITERAL
	| DECRYPTION  BY  PASSWORD  OPEQ  SQ_LITERAL
	| ENCRYPTION  BY  PASSWORD  OPEQ  SQ_LITERAL
	;

// Database common
//
db_filespec_list
	: af+=db_filespec (COMMA af+=db_filespec)*

	;

db_filespec
	: LPAREN 

		adfs_name?
        adfs_newname?
        adfs_filename?
        adfs_size?
        adfs_max?
        adfs_filegrowth?
        (COMMA  OFFLINE)?

	  RPAREN 
	;

// Common trigger syntax
//
common_trigger
    :   (keyw_id_list | ALL)
        common_trigger_on
    ;

common_trigger_on
    : ON 
        (

              DATABASE
            | ALL SERVER
            | keyw_id
        )
    ;

