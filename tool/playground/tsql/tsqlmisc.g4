/**
 * This grammar covers T-SQL statements that don't particularly fall in to
 * any other category.
 */
parser grammar tsqlmisc;

tokens
{
    PROCESS  // Node type for KILL process
}

///////////////////////////////////////////////////////////
// Miscellaneous statements
//
miscellaneous_statements
    : begin_statement
	| break_statement
	| checkpoint_statement
	| close_statement
	| commit_statement
	| continue_statement
    | dbcc_statement
    | declare_statement
    | delete_statement
    | disable_statement
    | enable_statement
    | end_conversation
    | waitfor_statement
    | get_statement
    | goto_statement
    | if_statement
    | insert_statement
    | kill_statement
    | merge_statement
    | move_statement
    | open_statement
    | print_statement
    | raiserror_statement
    | readtext_statement
    | receive_statement
    | reconfigure_statement
    | restore_statement
    | return_statement
    | revert_statement
    | rollbacksave_statement
    | send_statement
    | set_statement
    | set_user
    | shutdown_statement
    | truncate_statement
    | update_statement
    | updatetext_statement
    | while_statement
    | writetext_statement
;

// End: Miscellaneous statements
///////////////////////////////////////////////////////////
begin_statement
	: BEGIN  SEMI ?
		(
			  (
				  CONVERSATION TIMER LPAREN keyw_id RPAREN TIMEOUT OPEQ INTEGER

				| DIALOG CONVERSATION? ID

					FROM SERVICE keyw_id
					TO SERVICE SQ_LITERAL (COMMA SQ_LITERAL)?
					(ON CONTRACT keyw_id)?
					(
						WITH
							(
								(RELATED_CONVERSATION_GROUP | RELATED_CONVERSATION) OPEQ keyw_id

							)?

                        (COMMA? LIFETIME OPEQ INTEGER)?
                        (COMMA? ENCRYPTION OPEQ (ON|OFF))?
					)?



				| DISTRIBUTED? TRANSACTION
					(keyw_id)?
						(WITH KMARK SQ_LITERAL?)?	// NOt allowed on DISTRIBUTED

				| TRY statement_block END  TRY 

				| CATCH statement_block END  CATCH 
			  )

			| statement_block END 

		)

        (SEMI )?
	;
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// BREAK statement
//
break_statement
	: BREAK 
	;
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// BULK statement
//
bulk_statement
	: BULK  INSERT
		keyw_id?

		FROM SQ_LITERAL
		(
			WITH
				LPAREN

					bulk_option_list

				RPAREN

		)?
	;

bulk_option_list
	: bulk_option (COMMA bulk_option)*
	;

bulk_option
	: CHECK_CONSTRAINTS
	| FIRE_TRIGGERS
	| KEEPIDENTITY
	| KEEPNULLS
	| TABLOCK

	| (
		  BATCHSIZE
		| FIRSTROW
		| KILOBYTES_PER_BATCH
		| LASTROW
		| MAXERRORS
		| ROWS_PER_BATCH
	  )
	  	OPEQ INTEGER

	| (
		  CODEPAGE
		| DATAFILETYPE
		| FIELDTERMINATOR
		| FORMATFILE
		| ROWTERMINATOR
		| ERRORFILE
	  )
	  	OPEQ SQ_LITERAL

	| ORDER
		LPAREN 
			( keyw_id (ASC|DESC)? (COMMA keyw_id (ASC|DESC)?)* )
		RPAREN 
	;
////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////
// CHECKPOINT statement
//
checkpoint_statement
	: CHECKPOINT  (expression)? (SEMI )?
	;
////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////
// CLOSE statement
//
close_statement
	: CLOSE 
		(
			  (GLOBAL)? keyw_id_part
			| MASTER KEY
			| SYMMETRIC KEY keyw_id
			| ALL SYMMETRIC KEYS
		)
		(SEMI )?
	;
////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////
// 	COMMIT statement
//
commit_statement
	: COMMIT 
			(
				  TRANSACTION (keyw_id)?
				| WORK
			)?

		(SEMI )?
	;
////////////////////////////////////////////////////////////////////////
// 	CONTINUE statement
//
continue_statement
	: CONTINUE (SEMI )?
	;
////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// BACKUP statement
//
backup_statement
	: BACKUP 
		(
			  (
				  DATABASE keyw_id

				  	backup_file_or_group_list?    // Specific file or groups?

				| LOG keyw_id
		   	  )
		  		TO backup_device_list
				  	mirror_to

				  	(WITH (DIFFERENTIAL | backup_with_options_list))?

			| CERTIFICATE keyw_id TO  KFILE  OPEQ  SQ_LITERAL
				backup_cert_key?

			| SERVICE? MASTER KEY  TO  KFILE  OPEQ  SQ_LITERAL
				ENCRYPTION  BY  PASSWORD  OPEQ  SQ_LITERAL

		)
	  (SEMI )?
	;

backup_cert_key
    : WITH  PRIVATE  KEY 
        LPAREN 

            backup_cert_opts

        RPAREN 
    ;

backup_cert_opts
    : bco+=backup_cert_opt (COMMA bco+=backup_cert_opt)*

    ;

backup_cert_opt
    : KFILE  OPEQ  SQ_LITERAL
    | (DECRYPTION|ENCRYPTION)  BY  PASSWORD  OPEQ  SQ_LITERAL
    ;

backup_file_or_group_list
    : fog+=backup_file_or_group (COMMA fog+=backup_file_or_group)*

    ;

backup_file_or_group
    : (KFILE|FILEGROUP|PAGE)  OPEQ  (keyw_id |SQ_LITERAL)
    | READ_WRITE_FILEGROUPS
    ;

mirror_to
	: (MIRROR TO backup_device_list)*
	;

backup_with_options_list
	: backup_with_options (COMMA backup_with_options)*
	;

backup_with_options
	: COPY ONLY
	| NO_LOG
	| NOINIT
	| INIT
	| NOSKIP
	| KSKIP
	| NOFORMAT
	| FORMAT
	| NO_CHECKSUM
	| CHECKSUM
	| STOP_ON_ERROR
	| CONTINUE_AFTER_ERROR
	| RESTART
	| KREWIND
	| NOREWIND
	| UNLOAD
	| NOUNLOAD
	| NORECOVERY
	| NO_TRUNCATE
	| TRUNCATE_ONLY

	| (
		  DESCRIPTION
		| PASSWORD
		| NAME
		| EXPIREDATE
		| MEDIADESCRIPTION
		| MEDIAPASSWORD
		| MEDIANAME
	  )
	  	 OPEQ (SQ_LITERAL | keyw_id)

	| (
		  RETAINDAYS
		| BLOCKSIZE
		| BUFFERCOUNT
		| MAXTRANSFERSIZE
	  )
		OPEQ ( INTEGER | keyw_id)

	| STATS OPEQ INTEGER
	| STANDBY OPEQ SQ_LITERAL
	;

backup_device_list
	: backup_device (COMMA backup_device)*
	;

backup_device
	: keyw_id
	| (DISK | TAPE | DATABASE_SNAPSHOT) OPEQ  (SQ_LITERAL | keyw_id)
	;

///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// DBCC statement
//

dbcc_statement
    : DBCC 

        (
              dbcc_dll
            | dbcc_checkalloc
            | dbcc_checkcatalog
            | dbcc_checkconstraints
            | dbcc_checkdb
            | dbcc_checkfilegroup
            | dbcc_checkident
            | dbcc_checktable
            | dbcc_cleantable
            | dbcc_concurrency
            | dbcc_dbreindex
            | dbcc_dropcleanbuffers
            | dbcc_freeproccache
            | dbcc_freesessioncache
            | dbcc_freesystemcache
            | dbcc_help
            | dbcc_indexdefrag
            | dbcc_inputbuffer
            | dbcc_opentran
            | dbcc_outputbuffer
            | dbcc_pintable
            | dbcc_proccache
            | dbcc_show_statistics
            | dbcc_showcontig
            | dbcc_shrinkdatabase
            | dbcc_shrinkfile
            | dbcc_sqlperf
            | dbcc_traceoff
            | dbcc_traceon
            | dbcc_tracestatus
            | dbcc_unpintable
            | dbcc_updateusage
            | dbcc_useroptions
        )

        SEMI ?
    ;

dbcc_dll
    : func_keyw_id LPAREN  FREE  RPAREN  (dbcc_with)?
    ;

dbcc_checkalloc
    : CHECKALLOC 

        (
            (
                  dbcc_form_1
                | dbcc_with
            )
        )?
    ;

dbcc_form_1
    : LPAREN 

            dbcc_dbname
            (COMMA ? (keyw_id|SQ_LITERAL|INTEGER))?

      RPAREN 

      (dbcc_with)?
    ;

dbcc_dbname
    : keyw_id
    | SQ_LITERAL
    | INTEGER
    ;

// NB: This is all options for all dbcc commands so you have to check they 
//     are valid in the AST walk
//
dbcc_with
    : WITH 

        (COMMA ? dbcc_with_option)+
    ;

dbcc_with_option
    :
      keyw_id
    ;

dbcc_checkcatalog
    : CHECKCATALOG 

         (
             (
                  dbcc_form_2
                | dbcc_with
             )
         )?
    ;

dbcc_form_2
    :   LPAREN 

            dbcc_dbname

        RPAREN 

        (dbcc_with)?
    ;

dbcc_checkconstraints
    : CHECKCONSTRAINTS 

        dbcc_form_2
    ;

dbcc_checkdb
    : CHECKDB 

        (
            (
                  dbcc_form_1
                | dbcc_with
            )
        )?
    ;

dbcc_checkfilegroup
    : CHECKFILEGROUP 

        (
            (
                  dbcc_form_1
                | dbcc_with
            )
        )?
    ;

dbcc_checkident
    : CHECKIDENT 

        dbcc_form_3
    ;

dbcc_form_3
    : LPAREN 

            dbcc_dbname
            (COMMA ? (keyw_id|SQ_LITERAL|INTEGER) (COMMA ? (keyw_id|INTEGER|SQ_LITERAL))?)?

      RPAREN 

      (dbcc_with)?
    ;

dbcc_checktable
    : CHECKTABLE 

        dbcc_form_1
    ;

dbcc_cleantable
    : CLEANTABLE 

        dbcc_form_3
    ;

dbcc_concurrency
    : CONCURRENCYVIOLATION
    ;

dbcc_dbreindex
    : DBREINDEX 

        dbcc_form_3
    ;

dbcc_dropcleanbuffers
    : DROPCLEANBUFFERS 

        (dbcc_with)?
    ;

dbcc_freeproccache
    : FREEPROCCACHE 

        (dbcc_with)?
    ;

dbcc_freesessioncache
    : FREESESSIONCACHE 

        (dbcc_with)?
    ;

dbcc_freesystemcache
    : FREESYSTEMCACHE 

        LPAREN  (ALL |SQ_LITERAL ) RPAREN 

        (dbcc_with)?
    ;

dbcc_help
    : HELP 

        dbcc_form_2
    ;

dbcc_indexdefrag
    : INDEXDEFRAG 

        dbcc_form_4
    ;

dbcc_form_4
    : LPAREN 

            dbcc_dbname
            (COMMA ? (keyw_id|SQ_LITERAL) (COMMA  (keyw_id|SQ_LITERAL) (COMMA ? (keyw_id|INTEGER|SQ_LITERAL))?)? )?

      RPAREN 

      (dbcc_with)?
    ;

dbcc_inputbuffer
    : INPUTBUFFER 

        dbcc_form_1
    ;

dbcc_opentran
    : OPENTRAN 

         (
             (
                  dbcc_form_2
                | dbcc_with
             )
         )?
    ;

dbcc_outputbuffer
    : OUTPUTBUFFER 

        dbcc_form_1
    ;

dbcc_pintable
    : PINTABLE  dbcc_form_1
    ;

dbcc_proccache
    : PROCCACHE 

        (dbcc_with)?
    ;

dbcc_show_statistics
    : SHOW_STATISTICS 

        dbcc_form_1
    ;

dbcc_showcontig
    : SHOWCONTIG 

        (
            (
                  dbcc_form_1
                | dbcc_with
            )
        )?
    ;

dbcc_shrinkdatabase
    : SHRINKDATABASE 

        (
            (
                  dbcc_form_3
                | dbcc_with
            )
        )?
    ;

dbcc_shrinkfile
    : SHRINKFILE 

        dbcc_form_3
    ;

dbcc_sqlperf
    : SQLPERF 

        dbcc_form_1
    ;

dbcc_traceoff
    : TRACEOFF 

        LPAREN 

            (COMMA ? OPMINUS? INTEGER)+

        RPAREN 

        (dbcc_with)?
    ;

dbcc_traceon
    : TRACEON 

        LPAREN 

            (COMMA ? OPMINUS? INTEGER)+

        RPAREN 

        (dbcc_with)?
    ;

dbcc_tracestatus
    : TRACESTATUS 

        LPAREN 

            (COMMA ? OPMINUS? INTEGER)*

        RPAREN 

        (dbcc_with)?
    ;

dbcc_unpintable
    : UNPINTABLE  dbcc_form_1
    ;

dbcc_updateusage
    : UPDATEUSAGE 

        dbcc_form_3
    ;

dbcc_useroptions
    : USEROPTIONS 

        (dbcc_with)?
    ;

// End: DBCC
///////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////
// DECLARE statement for local variables
//
declare_statement
    : DECLARE 

        (
               declare_cursor        // See tsqlcursors
            | declare_list                                  // Local variables
        )

      SEMI ?
    ;

declare_list
    : declare_list_item (COMMA declare_list_item)*

    ;

declare_list_item
    : keyw_id declare_as
    ;

declare_as
    : opt_as declare_as_opts
    ;

declare_as_opts
    : cr_type_data_type (OPEQ expression)?
    | TABLE  LPAREN  declare_defs RPAREN 
    ;

declare_defs
    : d+=declare_def (COMMA d+=declare_def)*

    ;

declare_def
    : declare_col
    | declare_table_constraint
    ;

declare_col
    : keyw_id
        (
              cr_type_data_type
            | AS expression
        )

      declare_col_stuff*
    ;

declare_col_stuff
    : ct_collate
    | declare_col_identity
    | ROWGUIDCOL
    | declare_col_constraint
    ;

declare_col_constraint
    : declare_col_constraint_el 
    ;

declare_col_constraint_el
    : (KNULL | KNOT KNULL)
	| (PRIMARY KEY  | UNIQUE)
    | (CLUSTERED | NONCLUSTERED)
	| CHECK  LPAREN  search_condition RPAREN 
	;

declare_col_identity
    : DEFAULT  expression
    | IDENTITY  ( LPAREN  OPMINUS? INTEGER COMMA  OPMINUS? INTEGER RPAREN  )
    ;

declare_table_constraint
    : (PRIMARY  KEY  | UNIQUE ) LPAREN  keyw_id_list RPAREN 
    | CHECK  LPAREN  search_condition RPAREN 
    ;

// End: DECLARE
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// Delete statement (can also be called using WITH common_table)
//
delete_statement
    : KDELETE 

        common_top_clause?
        (delete_from_clause)?
        output_clause?
        from_clause?
        delete_where_clause?
        option_clause?
      (SEMI )?
    ;

delete_where_clause
    : WHERE 

        (
              search_condition
            | delete_current
        )
    ;

delete_current
    : CURRENT  OF  (GLOBAL)? keyw_id
    ;

delete_from_clause
    : opt_from 
        table_source_primitive     
    ;
    
opt_from
    : FROM 
    | 
    ;

// End: DELETE statement
///////////////////////////////////////////////////////////


