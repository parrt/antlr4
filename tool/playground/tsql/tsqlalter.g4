parser grammar tsqlalter;

tokens
{
	FULLTEXT_COL,	
	PARAMS,
	PARAM,
	COL_CONSTRAINTS,
	COL_CONSTRAINT,
	TABLE_CONSTRAINTS,
	TABLE_CONSTRAINT
}



///////////////////////////////////////////////////////////
// ALTER statements
alter_statement
		: ALTER 
			(
				  alter_application
				| alter_assembly
				| alter_asymmetric
				| alter_authorization
				| alter_certificate
				| alter_credential
				| alter_database
				| alter_endpoint
				| alter_fulltext
				| alter_function
				| alter_index
				| alter_login
				| alter_master
				| alter_message
				| alter_partition
				| alter_procedure
				| alter_queue
				| alter_remote
				| alter_role
				| alter_route
				| alter_schema
				| alter_service
				| alter_symmetric
				| alter_table
				| alter_trigger
				| alter_user
				| alter_view
				| alter_xml
			)
		;
// End: ALTER statements
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// alter_application statements
//
alter_application
    : create_application
	;
	
// End: alter_application
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// alter_assembly statements
//
alter_assembly
    : ASSEMBLY  assembly_name 
    
    	assembly_from?
    	assembly_with?
    	assembly_drop?
    	assembly_add?
    	
    	SEMI ?
    ;
    	
assembly_drop
	: DROP  KFILE  ass_file_list
	;
	
ass_file_list
	: ALL
	| a+=ass_file (COMMA af+=ass_file)
	
	;
	
ass_file
	: SQ_LITERAL
	;
	
assembly_add
    : KADD KFILE FROM cfs+=client_file_specifier (COMMA cfs+=client_file_specifier)*
    
    ;	
    
client_file_specifier
	: SQ_LITERAL (AS  SQ_LITERAL)?
	| binary_list AS  SQ_LITERAL
	;
    	 
binary_list
	: binary (COMMA  binary)*
	;
	
binary
	: HEXNUM
	;   
    	 

// End: alter_assembly
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// alter_asymmetric statements
//
alter_asymmetric
    : ASYMMETRIC  KEY  keyw_id alter_option 
    	SEMI ?
    ;
    
alter_option
	: REMOVE  PRIVATE  KEY 
	| WITH  PRIVATE  KEY  LPAREN  ak_password_option RPAREN 
	;
		
// End: alter_asymmetric
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// alter_authorization statements
//
alter_authorization
    : AUTHORIZATION 
    	aa_on
    	aa_to
    	(SEMI )?
    ;

aa_on
	: ON  entity_type? keyw_id
	;
	    
aa_to
	: TO  
    	(
    		  SCHEMA OWNER
    		| keyw_id
    	)
	;
	
entity_type
	:  	(
			  OBJECT
			| TYPE
			| XML SCHEMA COLLECTION
			| FULLTEXT CATALOG
			| SCHEMA
			| ASSEMBLY
			| ROLE
			| MESSAGE TYPE
			| CONTRACT
			| SERVICE
			| REMOTE SERVICE BINDING
			| ROUTE
			| SYMMETRIC KEY
			| ENDPOINT
			| CERTIFICATE
			| DATABASE
		)
			
			COLON  COLON 
	;
// End: alter_authorization
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// alter_certificate statements
//
alter_certificate
    : CERTIFICATE  keyw_id ac_opts
    	SEMI ?
    ;

ac_opts
	: REMOVE  PRIVATE  KEY 
	| WITH 
		(
			  PRIVATE KEY  LPAREN  private_key_list RPAREN 
			| ACTIVE FOR  BEGIN_DIALOG  OPEQ  (ON | OFF)
		)
	;
	

		
// End: alter_certificate
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// alter_credential statements
//
alter_credential
	: create_credential
    ;

// End: alter_credential
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// alter_database statements
//
alter_database
    : DATABASE  keyw_id
    	(
    		  ad_add_or_modify_files
    		| ad_add_or_modify_filegroups
    		| ad_set_database_options
    		| ad_modify_name
    		| ad_collate
    	)
    	SEMI ?
    ;
    
ad_collate
	: COLLATE  keyw_id
	;
	
ad_modify_name
	: MODIFY  NAME OPEQ  keyw_id
	;
	
ad_add_or_modify_files
	: KADD
		(
			  KFILE db_filespec_list
			  	( 	  adfs_filegroup
			  	
			  			
			  		| 	
			  	)
			| LOG KFILE db_filespec_list
			
		)
	| REMOVE KFILE rfid=keyw_id
	
			
	| MODIFY KFILE db_filespec
	
	;

adfs_filegroup
    : TO  FILEGROUP  (keyw_id|SQ_LITERAL)
    ;

adfs_name
	: NAME  OPEQ  (keyw_id|SQ_LITERAL)
	;
	
adfs_filegrowth
	: COMMA ? FILEGROWTH  OPEQ  INTEGER (sz_suffix | OPMOD)
	;
	
adfs_size
	: COMMA ? SIZE  OPEQ  INTEGER sz_suffix
	;
	
adfs_filename
	: COMMA ? FILENAME  OPEQ  (keyw_id|SQ_LITERAL)
	;
	
adfs_newname
	: COMMA ? NEWNAME  OPEQ  (keyw_id|SQ_LITERAL)
	;
	
adfs_max
	: COMMA ? MAXSIZE  OPEQ  (UNLIMITED | INTEGER sz_suffix)
	;
	
sz_suffix
	: KB
	| MB
	| GB
	| TB
	;
	
ad_add_or_modify_filegroups
	: KADD FILEGROUP  (keyw_id|SQ_LITERAL)
	| REMOVE FILEGROUP  (keyw_id|SQ_LITERAL)
	| MODIFY FILEGROUP  (keyw_id|SQ_LITERAL)
			(
				  READ_ONLY
				| READ_WRITE
				| DEFAULT
				| NAME OPEQ  (keyw_id|SQ_LITERAL)
			)
	;

ad_set_database_options
	: SET ad_optionspec_list ad_with_termination?
	
	;
    
ad_with_termination
    : WITH  ad_termination
    ;

ad_optionspec_list
	: ao+=ad_optionspec (COMMA ao+=ad_optionspec)*

	;
	
ad_optionspec
	: ad_db_state_option
	| ad_db_uaccess_option
	| ad_db_update_option
	| ad_ext_access_option
	| ad_cursor_option
	| ad_auto_option
	| ad_sql_option
	| ad_recovery_option
	| ad_db_mirror_option
	| ad_svc_brkr_option
	| ad_date_cor_optim_option
	| ad_param_option
	| ad_snapshot_option
    | ad_compatibility
	;

ad_compatibility
    : COMPATIBILITY_LEVEL  OPEQ  INTEGER
    ;

ad_db_state_option
	: ONLINE
	| OFFLINE
	| EMERGENCY
	;
	
ad_db_uaccess_option
	: SINGLE_USER
	| RESTRICTED_USER
	| MULTI_USER
	;

ad_db_update_option
	: READ_ONLY
	| READ_WRITE
	;

ad_ext_access_option 
	: DB_CHAINING  (ON | OFF)
	| TRUSTWORTHY  (ON | OFF)
	;

ad_cursor_option
	: CURSOR_CLOSE_ON_COMMIT  (ON | OFF)
	| CURSOR_DEFAULT  (LOCAL | GLOBAL)
	;

ad_auto_option
	: AUTO_CLOSE  						(ON | OFF)
	| AUTO_CREATE_STATISTICS  			(ON | OFF)
	| AUTO_UPDATE_STATISTICS 			(ON | OFF)
	| AUTO_UPDATE_STATISTICS_ASYNC 		(ON | OFF)
    | AUTO_SHRINK                   	(ON | OFF)
	;

ad_sql_option
	: ANSI_NULL_DEFAULT  				(ON | OFF)
	| ANSI_NULLS 						(ON | OFF)
	| ANSI_PADDING 						(ON | OFF)
	| ANSI_WARNINGS 					(ON | OFF)
	| ARITHABORT 						(ON | OFF)
	| CONCAT_NULL_YIELDS_NULL 			(ON | OFF)
	| NUMERIC_ROUNDABORT 				(ON | OFF)
	| QUOTED_IDENTIFIER 				(ON | OFF)
	| RECURSIVE_TRIGGERS 				(ON | OFF)
	;

ad_recovery_option
	: RECOVERY  			(FULL | BULK_LOGGED | SIMPLE )
	| TORN_PAGE_DETECTION 	(ON | OFF)
	| PAGE_VERIFY 			(CHECKSUM | TORN_PAGE_DETECTION | NONE)	
	;

ad_db_mirror_option
	: PARTNER 
		(
			  OPEQ  SQ_LITERAL
			| FAILOVER
			| FORCE_SERVICE_ALLOW_DATA_LOSS
			| OFF
			| RESUME
			| SAFETY	(ON | OFF)
			| SUSPEND
			| TIMEOUT INTEGER
		)
	| WITNESS 
		(
			  OPEQ  SQ_LITERAL
			| OFF
		)
	;

ad_svc_brkr_option
	: ENABLE_BROKER
	| DISABLE_BROKER
	| NEW_BROKER
	| ERROR_BROKER_CONVERSATIONS
	;

ad_date_cor_optim_option
	: DATE_CORRELATION_OPTIMIZATION  (ON | OFF)
	;

ad_param_option
	: PARAMETERIZATION  ( SIMPLE | FORCED )
	;

ad_snapshot_option
	: ALLOW_SNAPSHOT_ISOLATION  	(ON | OFF)
	| READ_COMMITTED_SNAPSHOT 		(ON | OFF)
	;
		
ad_termination
	: ROLLBACK  AFTER  INTEGER SECONDS ?
	| ROLLBACK  IMMEDIATE
	| NO_WAIT
	;
// End: alter_database
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// alter_endpoint statements
//
alter_endpoint
    : ENDPOINT  keyw_id
    	ae_auth?
    	ae_state?
    	ae_as?
    	ae_for
    	SEMI ?
    ;

ae_state
	: STATE  OPEQ 
    			(
    				  STARTED
    				| STOPPED
    				| DISABLED
    			)
	;
	
ae_auth
	: AUTHORIZATION  keyw_id
	;
	    
ae_as
	: AS  ep_protocols
	;
	
ae_for
    : FOR  ep_languages
	;
    	
ep_protocols
	: HTTP 
		LPAREN 
			ep_protocols_http_path?
			ep_protocols_http_ports
			ep_protocols_http_site?
			ep_protocols_http_clear_port?
			ep_protocols_http_ssl_port?
            ep_protocols_http_authentication?
			ep_protocols_http_auth_realm?
			ep_protocols_http_default_login_domain?
			ep_protocols_http_compression?
		RPAREN 
	| TCP 
		LPAREN
			ep_protocols_tcp_listener_port
			ep_protocols_tcp_listener_ip?
		RPAREN
	;

ep_protocols_tcp_listener_port
	: LISTENER_PORT  OPEQ  INTEGER
	;
	
ep_protocols_tcp_listener_ip
	: COMMA ? LISTENER_IP  OPEQ 
						(
							  ALL
							| four_part_ip
							| LPAREN  DQ_LITERAL RPAREN 
						)
	;
	
ep_protocols_http_path
	: COMMA ? PATH  OPEQ  SQ_LITERAL
	;
	
ep_protocols_http_ports
	: COMMA ? PORTS  OPEQ  LPAREN  ( CLEAR SSL? | SSL CLEAR? ) RPAREN 
	;
	
ep_protocols_http_site
	: COMMA ? SITE  OPEQ  ( OPMUL | OPPLUS | SQ_LITERAL )
	;

ep_protocols_http_clear_port
	: COMMA ? CLEAR_PORT  OPEQ  INTEGER
	;
	
ep_protocols_http_ssl_port
	: COMMA ? SSL_PORT  OPEQ  INTEGER
	;
	
ep_protocols_http_authentication
	: COMMA ? AUTHENTICATION  OPEQ 
				LPAREN 
					ep_auth_list
				RPAREN 
	;
	
ep_protocols_http_auth_realm
	: COMMA ? AUTH_REALM  OPEQ  (SQ_LITERAL | NONE) 
	;
	
ep_protocols_http_default_login_domain
	: COMMA ? DEFAULT_LOGON_DOMAIN  OPEQ  (SQ_LITERAL | NONE)
	;
	
ep_protocols_http_compression
	: COMMA ? COMPRESSION  OPEQ  (ENABLED | DISABLED)
	;
	

four_part_ip
	: INTEGER DOT  INTEGER DOT  INTEGER DOT  INTEGER
	;
	
ep_auth_list
	: ep_auth (COMMA  ep_auth)*
	;
	
ep_auth
	: BASIC
	| DIGEST
	| NTLM
	| KERBEROS
	| INTEGRATED
	;
	
ep_languages
	: ep_soap
	| ep_service_broker
	| ep_database_mirroring
	| TSQL
	;

ep_soap
	: SOAP 
		LPAREN 
			ep_add_webmethod_list?
			ep_alter_webmethod_list?
			(COMMA ? ep_drop_webmethod_list)?
            (COMMA ? ep_soap_optlist)?
        RPAREN 
	;

ep_soap_optlist
	: ep_soap_opt (COMMA ? ep_soap_opt)*
	;

ep_soap_opt
	: BATCHES  			OPEQ  (ENABLED | DISABLED)
	| WSDL  			OPEQ  (NODE | DEFAULT| SQ_LITERAL)
	| SESSIONS  		OPEQ  (ENABLED | DISABLED)
	| LOGIN_TYPE  		OPEQ  (MIXED | WINDOWS)
	| SESSION_TIMEOUT 	OPEQ  INTEGER
	| DATABASE  		OPEQ  (SQ_LITERAL | DEFAULT)
	| NAMESPACE  		OPEQ  (SQ_LITERAL | DEFAULT)
	| SCHEMA  			OPEQ  (NONE | STANDARD)
	| CHARACTER_SET  	OPEQ  (SQL | XML)
	| HEADER_LIMIT  	OPEQ  INTEGER
	;

ep_add_webmethod_list
	: ep_add_webmethod (COMMA  ep_add_webmethod)*
	;

ep_add_webmethod
	: KADD  WEBMETHOD  SQ_LITERAL (DOT  SQ_LITERAL)?
		ep_wm_params
	;
	
ep_alter_webmethod_list
	: ep_alter_webmethod (COMMA  ep_alter_webmethod)*
	;
	
ep_alter_webmethod
	: ALTER  WEBMETHOD  SQ_LITERAL (DOT  SQ_LITERAL)?
		ep_wm_params
	;
	
ep_wm_params
	: 	LPAREN 
			ep_wm_params_name
			ep_wm_params_schema?
			ep_wm_params_format?
		RPAREN 
	;
	
ep_wm_params_name
	: NAME  OPEQ  SQ_LITERAL
	;
	
ep_wm_params_schema
	: COMMA  SCHEMA  OPEQ  (NONE | STANDARD | DEFAULT)
	;
	
ep_wm_params_format
	: COMMA  FORMAT  OPEQ  (ALL_RESULTS | ROWSETS_ONLY | NONE)
	;
	
ep_drop_webmethod_list
	: ep_drop_webmethod (COMMA  ep_drop_webmethod)*
	;
	
ep_drop_webmethod
	: DROP  WEBMETHOD  SQ_LITERAL (DOT  SQ_LITERAL)?
	;
	
ep_service_broker
	: SERVICE_BROKER 
		LPAREN 
			ep_sb_authentication?
			ep_sb_encryption?
			ep_sb_message_forwarding?
			ep_sb_message_forward_size?
		RPAREN 
	;

ep_sb_message_forwarding
	: COMMA ? MESSAGE_FORWARDING  OPEQ  (ENABLED | DISABLED)
	;

ep_sb_message_forward_size
	: COMMA ? MESSAGE_FORWARD_SIZE  OPEQ  INTEGER
	;
	
ep_sb_authentication
	: AUTHENTICATION OPEQ
			(
				  w=WINDOWS (n=NTLM | ker=KERBEROS | neg=NEGOTIATE)? (c=CERTIFICATE k=keyw_id)?
				| c=CERTIFICATE k=keyw_id  (w=WINDOWS (n=NTLM | ker=KERBEROS | neg=NEGOTIATE)?)?
			)
			
	;
	
ep_sb_encryption
	: COMMA ? ENCRYPTION  OPEQ 
					(
						  DISABLED
						| (SUPPORTED | REQUIRED) 
								(ALGORITHM ID )?
					)
	;
				
ep_database_mirroring
	: DATABASE_MIRRORING 
		LPAREN 
			ep_sb_authentication?
			ep_sb_encryption?
			ep_database_mirroring_role
		RPAREN 
	;

ep_database_mirroring_role
	: COMMA ? ROLE  OPEQ  (WITNESS | PARTNER | ALL)
	;
	
// End: alter_endpoint
///////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////
// alter_fulltext statements
//
alter_fulltext
    : FULLTEXT 
    	(	
    		  alter_fulltext_catalog
		    | alter_fulltext_index
	    )
	  SEMI ?
    ;

alter_fulltext_index
	: KINDEX  ON  keyw_id
    	(
    		  ENABLE
    		| DISABLE
    		| SET  CHANGE_TRACKING (MANUAL | AUTO | OFF )
    		| KADD LPAREN 
    				fulltext_col (COMMA fulltext_col)*
    			  RPAREN 
    			  ( WITH NO POPULATION )?
    			  
    		| DROP
    			LPAREN 
    				keyw_id_list 
    			RPAREN 
    			 ( WITH NO POPULATION )?
    		| START ( FULL | INCREMENTAL | UPDATE ) POPULATION
    		| ( STOP | PAUSE | RESUME) POPULATION
    	)
	;
	
alter_fulltext_catalog
	:	CATALOG  keyw_id
    	(
    		  REBUILD (WITH  ACCENT_SENSITIVITY OPEQ  (ON | OFF))?
    		| REORGANIZE
    		| AS  DEFAULT
    	)
	;
	
fulltext_col
	: ki1=keyw_id ( TYPE COLUMN ki2=keyw_id )? (LANGUAGE language_term)?
	
	;   
 
language_term
	: SQ_LITERAL
	| HEXNUM
	;
	
// End: alter_fulltext
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// alter_function statements
//
alter_function
	: FUNCTION  keyw_id
	
		alter_function_params
		alter_function_returns
		SEMI ?
	;

// Parameter specification is good for all types of
// functions: CLR, inline table-value, etc.
//
alter_function_params
	:	LPAREN
			(
				fps+=function_parameter_spec (COMMA fps+=function_parameter_spec)*
			)?
		RPAREN
		
	;
	
// Syntax available here vairies according to the type of the function
// which we do not know or care to know at this point of course becaues
// this is the parser and does not do semantic checks. Semantics are
// left for the tree-parser.
// Hence we can have all of the syntax for each type of function come next,
// thoguh we can syntactically differentiate the types to some degree, we do
// so only with a rewrite rule to the tree grammar.
//
alter_function_returns
	:	RETURNS 
		(
			// Scalar functions return data elelements and so are typed
			// as such. Note that data types are picked up as identifiers
			// and then checked semantically to ensure their validity. Again,
			// this type of semantic checking is left to the tree parser
			// 
			   data_type
			   (
			   		// However, if we have an identifier followed by a
			   		// TABLE keyword, then this is a Multistatement table-valued
			   		// function, which allows a slightly different syntax
			   		//
			   		afr_table?
			   		(afr_with)?
					afr_as	   		
			   )
			| TABLE table_type_definition?
				( WITH function_option (COMMA function_option)*)?
				AS?
				(
					  BEGIN
						function_body
						RETURN
					  END
					| RETURN
						LPAREN		// Inline table-bodied function
							select_statement
						RPAREN
				)
		)
    ;

afr_as
	: AS?		
		(
			  function_body
			| EXTERNAL NAME  keyw_id	// For CLR Functinos ONLY
		)
	;
	
	
afr_with
	: WITH  function_option (COMMA  function_option)*
	;
	
afr_table
	: TABLE  table_type_definition
	;
    
table_type_definition
	: LPAREN 
		ct_col_def_list
		
	  RPAREN 
	;
	
filegroup
	: SQ_LITERAL
	| INTEGER
	;

index_option_list
	: io+=index_option (COMMA io+=index_option)*

	;
	
index_option
	: (MAXDOP|FILLFACTOR)  OPEQ  INTEGER 
	| (
		  PAD_INDEX 
		| IGNORE_DUP_KEY 
		| STATISTICS_NORECOMPUTE 
		| ALLOW_ROW_LOCKS 
		| ALLOW_PAGE_LOCKS 
        | ONLINE 
        | SORT_IN_TEMPDB 
	  ) 
			OPEQ  ( ON | OFF)
    | table_option // SQL 2008 R2
	;
	
function_option
	: ENCRYPTION					// Exclude in smeantic checking if CLR function
	| SCHEMABINDING					// Exclude in semantic checking if CLR function
	| RETURNS  KNULL ON  KNULL  KINPUT  // This clause and CALLED ON are mutually exclusive. Check in semantic pass
	| CALLED  ON  KNULL KINPUT 
	| execute_as_clause
	;
	
execute_as_clause
	: EXECUTE  AS  (CALLER | SELF | OWNER | SQ_LITERAL ) // EXECUTE is tokenzied by EXEC or EXECUTE keywords
	;
	
function_body
	: statements
	;
	
function_parameter_spec
	: keyw_id AS ? data_type (OPEQ  expression)?
	;
	
data_type
    : data_type_el 
    ;

data_type_el
	: keyw_id
		( 
			LPAREN  (INTEGER|KMAX|KMIN) (COMMA  INTEGER)? RPAREN 
		)?
	;
	
// End: alter_function
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// alter_index statements
//
alter_index
    : KINDEX  (keyw_id | ALL)
    	ON  keyw_id
    	(
    		  REBUILD
    		  	(
    		  		  ai_with
    		  		| ai_partition
    		  	)?
    		| DISABLE
    		| REORGANIZE
    			(
    				PARTITION OPEQ  INTEGER
    			)?
    			(
    				WITH LPAREN  LOB_COMPACTION OPEQ  (ON | OFF) RPAREN 
    			)?
    		| SET LPAREN  set_index_option_list RPAREN 
    	)
    	SEMI ?
    ;
    
ai_partition
	: PARTITION  OPEQ  (INTEGER| ALL)
    		  	(
    		  		WITH LPAREN  sp_rebuild_index_option_list RPAREN 
    		  	)?
	;
	
ai_with
	: WITH  LPAREN  rebuild_index_option_list RPAREN 
	;
	
set_index_option_list
	: s+=set_index_option (COMMA  s+=set_index_option)*
	;

set_index_option
	: ( ALLOW_ROW_LOCKS | ALLOW_PAGE_LOCKS | IGNORE_DUP_KEY | STATISTICS_NORECOMPUTE) 
		OPEQ 
			(ON|OFF)
	;

sp_rebuild_index_option_list
	: sp_rebuild_index_option (COMMA  sp_rebuild_index_option)*
	;
	
sp_rebuild_index_option
	: MAXDOP  OPEQ  INTEGER
	| SORT_IN_TEMPDB  OPEQ  (ON | OFF)
    | table_option
	;

rebuild_index_option_list
	: o+=rebuild_index_option (COMMA  o+=rebuild_index_option)*
	;

rebuild_index_option
	: (MAXDOP | FILLFACTOR )  OPEQ  INTEGER
	|
		(
			  PAD_INDEX
			| SORT_IN_TEMPDB
			| IGNORE_DUP_KEY
			| STATISTICS_NORECOMPUTE
			| ONLINE
			| ALLOW_ROW_LOCKS
		) 
			OPEQ  (ON | OFF)
	;

    
   
// End: alter_index
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// alter_login statements
//
alter_login
    : LOGIN 
    
    	keyw_id		// Login name is NOT delimited (which is stupid but that's what you get
    	
    	(
    		  ENABLE
    		| DISABLE
    		| WITH  set_option_list
    	)
   	
  	  SEMI ?
	;

set_option_list
	: set_option (COMMA  set_option)*
	;
	
set_option
	: PASSWORD  OPEQ  SQ_LITERAL HASHED?
    	(
    		  OLD_PASSWORD OPEQ  SQ_LITERAL
    		| MUST_CHANGE UNLOCK?
    		| UNLOCK MUST_CHANGE?	
    	)?
    | (
    	  DEFAULT_DATABASE 
    	| DEFAULT_LANGUAGE
    	| CREDENTIAL
    	| NAME
      ) 
    	OPEQ  keyw_id
    | (
    	  CHECK_POLICY
    	| CHECK_EXPIRATION
      ) 
      	OPEQ  (ON | OFF)
    | NO  CREDENTIAL
    ;
    
// End: alter_login
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// alter_master statements
//
alter_master
    : MASTER  KEY
    	(
    		  FORCE? REGENERATE WITH  ENCRYPTION  BY  PASSWORD  OPEQ  SQ_LITERAL
    		| (KADD | DROP)
    				ENCRYPTION  BY  	(
    									  SERVICE  MASTER  KEY
    									| PASSWORD  OPEQ  SQ_LITERAL
    								)
    	)
    	SEMI ?
    ;
// End: alter_master
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// alter_message statements
//
alter_message
    : MESSAGE  TYPE  keyw_id_part		// Not allowed to have server or database names
    
    	VALIDATION 
    	  OPEQ 
    		(
    			  NONE
    			| EMPTY
    			| WELL_FORMED_XML
    			| VALID_XML WITH  SCHEMA  COLLECTION  keyw_id
    		)
    	SEMI ?
    ;
// End: alter_message
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// alter_partition statements
//
alter_partition
    : PARTITION 
    	(
    		  FUNCTION keyw_id LPAREN  RPAREN 
    		  (
    		  	(SPLIT | MERGE) RANGE  LPAREN  expression RPAREN 
    		  )
    		| SCHEME keyw_id NEXT  USED  (keyw_id|SQ_LITERAL)?
    	)
    	SEMI ?
    ;
// End: alter_partition
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// alter_procedure statements
//
alter_procedure
    : PROCEDURE  keyw_id (SEMI  INTEGER)?
    
		procedure_param_list?
    	alter_procedure_with?
    	(FOR  REPLICATION)?
    	alter_procedure_as
    ;

alter_procedure_with
	: WITH  procedure_option_list
	;
	
alter_procedure_as
	: AS 
    	(
    		  EXTERNAL NAME  keyw_id SEMI ?
    		| unblocked_statements
    	)
	;
	
	
// End: alter_procedure
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// alter_queue statements
//
alter_queue
    : QUEUE  keyw_id WITH

    	queue_element_list

    	SEMI ?
    ;
	
// End: alter_queue
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// alter_remote statements
//
alter_remote
    : REMOTE  SERVICE BINDING  keyw_id
		create_remote_with
    	SEMI ?
    ;
    

	
// End: alter_remote
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// r_role statements
//
alter_role
    : ROLE 
    	keyw_id WITH  NAME OPEQ  keyw_id
    	
    	SEMI ?
    ;
// End: r_role
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// r_route statements
//
alter_route
    : ROUTE  keyw_id_part
    	route_with
    	SEMI ?
    ;   
 
// End: r_route
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// r_schema statements
//
alter_schema
    : SCHEMA 
    	keyw_id TRANSFER  keyw_id
    	SEMI ?
    ;
// End: r_schema
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// alter_service statements
//
alter_service
    : SERVICE  
    	(
	    	  keyw_id_part as_queue_opts
	    	| as_master
	    )
    	SEMI ?
    ;

as_master
    : MASTER  KEY 
        (
              as_regenerate_opt
            | as_recover_opt
            | as_add_drop
        )
    ;

as_regenerate_opt
    : FORCE? REGENERATE
    ;

as_recover_opt
    : WITH  OLD_ACCOUNT  OPEQ  SQ_LITERAL COMMA  OLD_PASSWORD  OPEQ  SQ_LITERAL
    | WITH  NEW_ACCOUNT  OPEQ  SQ_LITERAL COMMA  NEW_PASSWORD  OPEQ  SQ_LITERAL
    ;

as_add_drop
    : (KADD | DROP)  ENCRYPTION BY  MACHINE  KEY 
    ;

as_queue_opts
    : (
          ON q=QUEUE k=keyw_id s=service_opts_list?
	 	| s=service_opts_list (ON q=QUEUE k=keyw_id)?
      )
    ;

service_opts_list
	: LPAREN s+=service_opts (COMMA s+=service_opts)* RPAREN

	;
	
service_opts
	: KADD  CONTRACT  keyw_id_part
	| DROP  CONTRACT  keyw_id_part
	;

// End: alter_service
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// alter_symmetric statements
//
alter_symmetric
    : SYMMETRIC  KEY keyw_id alter_symmetric_option
    	SEMI ?
    ;

alter_symmetric_option
	: alter_sym_drop_list
	| alter_sym_add_list
	;

alter_sym_drop_list
	: a+=alter_sym_drop (COMMA a+=alter_sym_drop)*

	;

alter_sym_drop
	: DROP  ENCRYPTION  BY  encrypting_mechanism
	;

encrypting_mechanism
	: CERTIFICATE  keyw_id
	| PASSWORD  OPEQ  SQ_LITERAL
	| (ASYMMETRIC | SYMMETRIC)  KEY  keyw_id
	;
	
alter_sym_add_list
	: a+=alter_sym_add (COMMA a+=alter_sym_add)*

	;
	
alter_sym_add
	: KADD  ENCRYPTION  BY  encrypting_mechanism
	;

// End: alter_symmetric
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// alter_table statements
//
alter_table
    : TABLE  keyw_id
    	(
    		  at_alter_column

    		| with_list
    		| DROP 	con_with_col_list
    		| (ENABLE | DISABLE)? TRIGGER
    				(
    					  ALL
    					| keyw_id_list
    				)
    		| SWITCH 	(PARTITION expression)?
    			TO keyw_id
    					(PARTITION expression)?


            | SET
                LPAREN 
                    FILESTREAM_ON OPEQ 
                        (    expression
                            | DEFAULT
                        )
                RPAREN 

            | REBUILD
                (PARTITION OPEQ  (ALL|expression))?
                (WITH LPAREN  index_option_list RPAREN )?
    	)
    	SEMI ?
    ;

at_alter_column
    : ALTER  COLUMN  column_name
    		  (
                  at_alter_column_add_drop
    			| at_alter_column_named
    		  )
    ;

at_alter_column_named
    : alter_column_named_item 
    ;

alter_column_named_item
    : keyw_id
            (
                LPAREN 
                    (
                          INTEGER (COMMA  INTEGER)?
                        | KMAX
                        | keyw_id			// xml_schema_collection
                    )
                RPAREN 
            )?
            ( COLLATE SQ_LITERAL )?
            ( KNULL | KNOT KNULL)?
    ;

at_alter_column_add_drop
    : (KADD | DROP) 
        (	  ROWGUIDCOL
            | PERSISTED
            | not_for_replication
        )
    ;

con_with_col_list
	: c+=con_with_col (COMMA c+=con_with_col)*

	;
	
con_with_col
	: (CONSTRAINT)? keyw_id
    		( WITH  drop_cluster_con_list )?
    | COLUMN  keyw_id
	;
	
drop_cluster_con_list
	: LPAREN
		d+=drop_cluster_con_opt (COMMA d+=drop_cluster_con_opt)*
	  RPAREN

	;
	
drop_cluster_con_opt
	: MAXDOP  OPEQ  INTEGER
	| ONLINE  OPEQ  (ON | OFF)
	| MOVE  TO 
		(
			  keyw_id ( LPAREN  keyw_id RPAREN  )?
		)
	;
    
with_list
	: w+=with_add (COMMA w+=with_add)*

	;
	
with_add
	: (WITH? (CHECK | NOCHECK))?
			(
				  KADD 
    				ct_col_def_list
    			| CONSTRAINT 
    				(
    					  ALL
    					| keyw_id_list
    				)
    		)
	;
	
	
// End: alter_table
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// alter_trigger statements
//
alter_trigger
    : create_trigger
    ;
	
// End: alter_trigger
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// alter_user statements
//
alter_user
    : USER  keyw_id
    		WITH  common_set_item_list	// Note - semantics must exclude some options for this
    	SEMI ?
    ;
// End: alter_user
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// alter_view statements
//
alter_view
    : create_view
    ;
    
// End: alter_view
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// alter_xml statements
//
alter_xml
    : create_xml
    ;
// End: alter_xml
///////////////////////////////////////////////////////////
