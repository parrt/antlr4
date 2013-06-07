/**
 * This grammar covers T-SQL statements that don't particularly fall in to
 * any other category.
 */
parser grammar tsqlmisc2;

///////////////////////////////////////////////////////////
// DISABLE TRIGGER
//
disable_statement
    : DISABLE  TRIGGER

        common_trigger

        SEMI ?
    ;



// End: DISABLE
///////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// ENABLE STATEMENT
//
enable_statement
    : ENABLE  TRIGGER

        common_trigger

        SEMI ?
    ;
// End: ENABLE STATEMENT
//////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// END CONVERSATION
//
end_conversation
    :

        END  CONVERSATION keyw_id

        ecWithClause?

        SEMI ?

    ;

ecWithClause
    : WITH 

        (
              ERROR OPEQ (INTEGER | keyw_id)
              DESCRIPTION OPEQ (SQ_LITERAL | keyw_id )
            | CLEANUP
        )
    ;

// End:
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// EXECUTE statement
//
execute_statement
    : exec_one 
    ;

exec_one
    : EXECUTE 
        exec_body
    ;

exec_body
    : (
              exec_as
            | exec_sp
      )

      (SEMI )?

    ;
//Execute stored procedure
//
exec_sp
    : exec_sp_func
    | exec_string_cmd
    ;

exec_string_cmd
    : LPAREN 
        exec_string_list
        exec_passthru?
      RPAREN 
      exec_string_cmd_as?
      (exec_string_cmd_at)?
    ;

exec_passthru
    : e+=exec_passthru_el (COMMA e+=exec_passthru_el)*

    ;

exec_passthru_el
    : COMMA expression OUTPUT?

    ;

exec_string_list
    : e+=exec_string_bit (OPPLUS e+=exec_string_bit)*

    ;

exec_string_bit
    : keyw_id | SQ_LITERAL
    ;

exec_string_cmd_as
    : AS  (LOGIN|USER) OPEQ (keyw_id|SQ_LITERAL)
    ;

exec_string_cmd_at
    : AT  keyw_id
    ;

exec_sp_func
    : keyw_id (OPEQ  keyw_id)? (SEMI INTEGER)?
      (exec_sp_param_list)?
      (WITH  RECOMPILE)?
    ;

exec_sp_param_list
    : e+=exec_sp_param (COMMA e+=exec_sp_param)*

    ;

exec_sp_param
    : (keyw_id OPEQ )?
        (
              expression ((OUTPUT|KOUT))?
            | DEFAULT
        )
    ;

exec_as
    : AS  exec_context
    ;

exec_context
    : (LOGIN | USER)  OPEQ  (keyw_id|SQ_LITERAL)
        exec_with?
    | CALLER
    ;

exec_with
    : WITH 

        (
              NO REVERT 
            | COOKIE  INTO  keyw_id
        )
    ;
// End: EXECUTE statement
///////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////
// WAITFOR {}
//
waitfor_statement
    : WAITFOR 

        (
              wait_stat
            | wait_delay
            | wait_time
        )
        SEMI ?
    ;

wait_delay
    : DELAY  (keyw_id|SQ_LITERAL|INTEGER)
    ;

wait_time
    : TIME  (keyw_id|SQ_LITERAL|INTEGER)
    ;

wait_stat
    : LPAREN 
            wait_for_sub_stat
      RPAREN 

        (COMMA  TIMEOUT (keyw_id | INTEGER))?
    ;
wait_for_sub_stat
    : get_statement
    | receive_statement
    ;
// End: WAITFOR {}
///////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////
// GET CONVERSATION
//
get_statement
    : GET  CONVERSATION GROUP  keyw_id FROM keyw_id

        SEMI ?
    ;
// End: GET CONVERSATION
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// GOTO
// As if SQL isn't bad enough on it's own, we need a GOTO
// statement to let people really screw up.
//
goto_statement
    : GOTO  func_keyw_id

        SEMI ?

    | func_keyw_id COLON 
    ;
// End: GOTO
///////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////
// IF statement
//
if_statement
    : IF 
        search_condition

        statements (SEMI )?

      (if_else)?

      (SEMI )?
    ;

if_else
    : ELSE  statements (SEMI )?
    ;

// End:
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// INSERT statement
//
insert_statement
    : INSERT 
        common_top_clause?
        insert_into
        insert_update_target

        (SEMI )?
    ;

insert_into
    : is_opt_into 
        (
              keyw_id
            | rowset_function
        )

        common_with_hints?
    ;

is_opt_into
    : INTO 
    | 
    ;

insert_update_target
    :
        (LPAREN  
            
            keyw_id_list RPAREN 

        )?   // column list
        output_clause?
        insert_update_target_tbl

    | DEFAULT  VALUES
    ;

insert_update_target_tbl
    : insert_update_target_values
    | execute_statement
    | select_statement
   // | LPAREN  select_statement RPAREN 
    ;

insert_update_target_values
    : VALUES  values_list_list
    ;

values_list_list
    : LPAREN i+=iut_values_list RPAREN (COMMA LPAREN i+=iut_values_list RPAREN)*
    
    ;

iut_values_list
    : i+=iut_value (COMMA i+=iut_value)*

    ;

iut_value
    : DEFAULT
    | expression  // Covers KNULL
    ;

// End:
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// MERGE statement
//
merge_statement
    : MERGE 
        common_top_clause?
        merge_into
        USING  table_source
        merge_on
        output_clause?
        (option_clause)?

        (SEMI )?
    ;

merge_on
    : ON  search_condition
        merge_matches?
    ;

merge_matches
    : when_clauses+

    ;

when_clauses
    : WHEN 
        (
              MATCHED (KAND  search_condition)? THEN  merge_matched
            | KNOT MATCHED
                (
                    (BY  TARGET )? (KAND  search_condition)?
                        THEN  merge_not_matched
                  | BY  SOURCE (KAND  search_condition)?
                        THEN  merge_matched
                )
        )
    ;

merge_matched
    : UPDATE  merge_set_clause
    | KDELETE
    ;

merge_set_clause
    : SET 
        merge_set_list
    ;

merge_set_list
    : s+=set_vars (COMMA s+=set_vars)*

    ;
    
merge_not_matched
    : INSERT 
        (LPAREN 

            keyw_id_list RPAREN 

        )?
        (
              insert_update_target_values
            | DEFAULT VALUES 
        )
    ;

merge_into
    : is_opt_into 
        (
              keyw_id
            | rowset_function
        )

        merge_with_hints?
        as_clause?
    ;

merge_hint_limited_list
    : t+=merge_hint_limited+

    ;

merge_hint_limited
		: table_hint_limited
        | KINDEX 
                    (
                          LPAREN  (INTEGER | func_keyw_id) (COMMA  (INTEGER | func_keyw_id))* RPAREN 
                        | OPEQ (INTEGER | func_keyw_id)
                    )
		;

merge_with_hints
    : WITH  LPAREN  merge_hint_limited_list RPAREN 
    ;

// End:
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// KILL statment
//
kill_statement
    : KILL 
        (
              kill_process
            | kill_query
            | kill_stats
        )

        SEMI ?
    ;

kill_query
    : KQUERY  NOTIFICATION  SUBSCRIPTION 

        (
              ALL
            | keyw_id
            | INTEGER
        )
    ;

kill_stats
    : STATS  JOB  (keyw_id|INTEGER)
    ;

kill_process
    : k=kill_process_uow
      (WITH STATUSONLY)?

    ;

kill_process_uow
    : keyw_id
    | INTEGER
    ;

// End: KILL statement
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// MOVE statement
//
move_statement
    : MOVE  CONVERSATION 

        keyw_id TO  keyw_id

        SEMI ?
    ;

// End: MOVE statement
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// OPEN statement
//
open_statement
    : OPEN 

        (
              open_key
            | open_cursor
        )

        SEMI ?
    ;

open_key
    : (MASTER  KEY |SYMMETRIC  KEY  keyw_id)

        DECRYPTION  BY 
        ok_encrypting_mechanism
    ;

ok_encrypting_mechanism
	: (ASYMMETRIC  KEY  | CERTIFICATE ) keyw_id (WITH  PASSWORD  OPEQ  SQ_LITERAL)?
	| PASSWORD  OPEQ  SQ_LITERAL
    | SYMMETRIC  KEY  keyw_id
	;

// End: OPEN
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// PRINT statement
//
print_statement
    : PRINT 

        expression

        SEMI ?
    ;

// End: PRINT
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// RAISERROR statement
//
raiserror_statement
    : RAISERROR 

        (
                LPAREN 

                    expression_list

                RPAREN 

                raiseerror_with?

              // SYBASE backwards compatibility
              //
            | expression (raise_list)?
        )
        SEMI ?
    ;

raise_list
    : e+=expression (COMMA  e+=expression)*
    ;

raiseerror_with
    : WITH  raiseerror_opt_list
    ;

raiseerror_opt_list
    : r+=raiseerror_opt (COMMA r+=raiseerror_opt)*

    ;

raiseerror_opt
    : LOG
    | NOWAIT
    | SETERROR
    ;

// End: RAISEERROR
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// READTEXT statement
//
readtext_statement
    : READTEXT 

        keyw_id keyw_id expression expression

        HOLDLOCK?

        SEMI ?
    ;

// End: READTEXT
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// RECEIVE statement
//
receive_statement
    : RECEIVE 

        common_top_clause?
        receive_col_list
        receive_from
        receive_into?
        receive_where?
    ;

receive_from
    : FROM  keyw_id
    ;

receive_where
    : WHERE 

        keyw_id OPEQ  keyw_id
    ;

receive_into
    : INTO  keyw_id
    ;

receive_col_list
    : r+=receive_col (COMMA r+=receive_col)*

    ;

receive_col
    : OPMUL

    | func_keyw_id OPEQ  expression

    | expression

        (AS  func_keyw_id)?
    ;

// End: RECEIVE
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// RECONFIGURE
//
reconfigure_statement
    : RECONFIGURE WITH  OVERRIDE
    ;

// End: RECONFIGURE
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// RESTORE
//
restore_statement
    : RESTORE 

        (
              restore_key
            | restore_database
            | restore_other
        )

        SEMI ?
    ;

restore_key
    : (MASTER  | SERVICE  MASTER ) KEY 

        rk_from
        ak_password_option

        FORCE?
    ;

rk_from
    :   FROM  KFILE  OPEQ  SQ_LITERAL
    ;

restore_database
    : (LOG|DATABASE) 

        keyw_id
        backup_file_or_group_list?    // Specific file or groups?
        restore_from?
        restore_with?
    ;

restore_with
    : WITH 

        PARTIAL?

        (COMMA ? rest_with_option)+
    ;

rest_with_option
    : rest_with_options

    ;

rest_with_options
    : KFILE OPEQ  (INTEGER | keyw_id)
    | MOVE (COMMA ? (keyw_id|SQ_LITERAL) TO  (keyw_id|SQ_LITERAL))+
    | keyw_id (OPEQ  (keyw_id|SQ_LITERAL) (AFTER SQ_LITERAL)?)?
    | STATS OPEQ  INTEGER
    ;

restore_from
    : FROM 

              backup_device_list
    ;

restore_other
    : (FILELISTONLY | HEADERONLY | LABELONLY | REWINDONLY | VERIFYONLY) 

        restore_from
        restore_with?
    ;

// End: RESTORE
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// RETURN statement
//
return_statement
    : common_return

        SEMI ?
    ;

// End: RETURN
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
//
//
revert_statement
    : REVERT

        (WITH  COOKIE  OPEQ  keyw_id)?

        SEMI ?
    ;
// End:
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// ROLLBACK statement
//
rollbacksave_statement
    : (ROLLBACK|SAVE) 

        (
              TRANSACTION ({ _input.LA(2) != COLON}? func_keyw_id)?
            | WORK
        )?

      SEMI ?
    ;
// End: ROLLBACK
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// SEND statement
//
send_statement
    : SEND 

        send_on
        send_message_type?
        (LPAREN  expression RPAREN )?

      SEMI ?
    ;

send_on
    : ON  CONVERSATION  keyw_id
    ;

send_message_type
    : MESSAGE  TYPE  keyw_id
    ;

// End: SEND
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// SET statement
//
set_statement
    : SET 
        (
              set_vars
            | set_flags
        )
        (SEMI )?
    ;

set_flags
    : common_flags_list (ON|OFF|keyw_id|SQ_LITERAL|INTEGER|HEXNUM)
    | special_flags     (ON|OFF|keyw_id|SQ_LITERAL|INTEGER|HEXNUM)?
    ;

common_flags_list
    : c+=common_flags (COMMA c+=common_flags)*

    ;

common_flags
    : keyw_id                    // Anything that is a flag that isn't a special keyword
    | IDENTITY_INSERT keyw_id
    | NUMERIC_ROUNDABORT
    | CONCAT_NULL_YIELDS_NULL
    ;

special_flags
    : DEADLOCK_PRIORITY 

        (
              LOW
            | NORMAL
            | HIGH
            | expression
        )
    | STATISTICS (IO|PROFILE|TIME|XML)
    | TRANSACTION  ISOLATION  LEVEL 

        (
              READ (COMMITTED|UNCOMMITTED)
            | REPEATABLE READ
            | SNAPSHOT
            | SERIALIZABLE
        )
    ;

set_vars
    : set_target
      setOperators 
      set_source
    ;

setOperators
    : OPEQ
    | OPPLUSEQ
    | OPMINUSEQ
    | OPMULEQ
    | OPDIVEQ
    | OPMODEQ
    | OPBANDEQ
    | OPBOREQ
    | OPBXOREQ
    ;
    
set_target
    : keyw_id
        (
            // Static property
            //
            COLON  COLON  keyw_id
        )?
    ;

set_source
    : expression
        (
            // Static property
            //
            COLON  COLON  keyw_id
        )?
            (set_func_parms)?

    | CURSOR  common_cursor_decl
    | DEFAULT
    ;

set_func_parms
    : LPAREN e=expression_list RPAREN

    ;
// End: SET
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
//
//
set_user
    : SETUSER 
        (
            (SQ_LITERAL | keyw_id) (WITH  RESET)?
        )?
    ;
// End:
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// SHUTDOWN
//
shutdown_statement
    : SHUTDOWN (WITH  NOWAIT)? SEMI ?
    ;
// End:
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// TRUNCATE statement
//
truncate_statement
    : TRUNCATE  TABLE 

        keyw_id

        SEMI ?
    ;
// End:
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// UPDATE
//
update_statement
    : UPDATE 

        (
              update_table
            | update_statistics
        )

        (SEMI )?
    ;

update_table
    :   common_top_clause?
        insert_into?     // Same as INSERT, auto insert an INTO node though the keyword is not there
        update_set
        output_clause?
        update_from?
        delete_where_clause?
        option_clause?
    ;

update_set
    : SET 
        update_set_list
    ;

update_set_list
    : u+=update_element (COMMA u+=update_element)*

    ;

update_element
    : keyw_id
        (

              OPEQ  (expression|DEFAULT) (OPEQ  (expression|DEFAULT))?
            | set_func_parms
        )
    ;

update_from
    : FROM  table_source_list
    ;

update_statistics
    : STATISTICS 

        keyw_id

        (stats_index_list)?
        update_stats_with?
    ;

stats_index_list
    : keyw_id
    | LPAREN  keyw_id_list RPAREN 
    ;

update_stats_with
    : WITH 
        (
              FULLSCAN
            | SAMPLE (keyw_id|INTEGER) (PERCENT | ROWS)?
            | RESAMPLE
            | update_stats_streams
        )
        (COMMA? (ALL|COLUMNS|KINDEX))?
        (COMMA? NORECOMPUTE)?
    ;

update_stats_streams
    : s+=uss_stream (COMMA s+=uss_stream)*

    ;

uss_stream
    : STATS_STREAM  OPEQ  keyw_id
    | ROWCOUNT  OPEQ  INTEGER
    | PAGECOUNT  OPEQ  INTEGER
    ;

// End: UPDATE
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// UPDATETEXT
//
updatetext_statement
    : UPDATETEXT 

        keyw_id keyw_id_part

        (KNULL | keyw_id | INTEGER)
        (KNULL | keyw_id | INTEGER)


       (WITH  LOG)?

       (expression (keyw_id|INTEGER)?)?

       SEMI ?
    ;
// End:
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// WHILE statement
//
while_statement
    : WHILE 
        search_condition
        statements
    ;

// End: WHILE
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
//
//
writetext_statement
    : WRITETEXT 

        keyw_id
        keyw_id
        (WITH  LOG)?
        expression

        SEMI ?
    ;
// End:
///////////////////////////////////////////////////////////
