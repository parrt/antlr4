parser grammar tsqlcreate;

tokens
{
    COL_DEF_LIST,   // List of column defintions
    COL_DEF,        // Column definition itself
    DATA_TYPE,      // Node header for data type specifier in create table
    TRIG_IUD,       // Trigger for insert update delete
    TRIG_DDL       // Trigger for DDL statements like CREATE
}

///////////////////////////////////////////////////////////
// CREATE statements
create_statement
	: CREATE  
		(
			  create_aggregate
			| create_application
			| create_assembly
			| create_asymmetric
			| create_certificate
            | create_contract
			| create_credential
			| create_database
            | create_default
			| create_endpoint
            | create_event
			| create_fulltext
			| create_function
			| create_index
			| create_login
			| create_master
			| create_message
			| create_partition
			| create_procedure
			| create_queue
			| create_remote
			| create_role
			| create_route
            | create_rule
			| create_schema
			| create_service
            | create_statistics
			| create_symmetric
            | create_synonym
			| create_table
			| create_trigger
            | create_type
			| create_user
			| create_view
			| create_xml
		)
	;



// End: CREATE statements
///////////////////////////////////////////////////////////



///////////////////////////////////////////////////////////
// create_aggreagate statements
//
create_aggregate
	: AGGREGATE  keyw_id
		LPAREN 
			expression expression
		RPAREN 
	  common_returns
	  external_name

      SEMI ?
	;

///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// create_application statements
//
create_application
    : APPLICATION  capp_role capp_list SEMI ?
    ;

capp_role
    : ROLE  keyw_id
    ;

capp_list
    : WITH  common_set_item_list
    ;
	
// End: create_application
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// create_assembly statements
//
create_assembly
    : ASSEMBLY  assembly_name
    
		authorization?
    	assembly_from
    	assembly_with?
    	
    	SEMI ?
    ;

	
// End: create_assembly
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// create_asymmetric statements
//
create_asymmetric
    : ASYMMETRIC  KEY  keyw_id
		authorization?
		create_asm_option 
		ak_password_option?
    	SEMI ?
    ;
    
create_asm_option
	: FROM  asym_key_source
	| WITH  ALGORITHM OPEQ  keyw_id
	;
	
asym_key_source
	: EXECUTABLE? KFILE  OPEQ  SQ_LITERAL
	| ASSEMBLY  SQ_LITERAL
	;
	
		
// End: create_asymmetric
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// create_certificate statements
//
create_certificate
    : CERTIFICATE  keyw_id
		authorization?
		cc_key_opts
		cc_active?
    	SEMI ?
    ;

cc_active
    : ACTIVE  FOR  BEGIN  DIALOG  OPEQ  (ON|OFF)
    ;
cc_key_opts
	: FROM 
		(
			  existing_keys
		)
    | generate_new_keys
	;

existing_keys
	: ASSEMBLY  keyw_id
	| (EXECUTABLE? KFILE  OPEQ  SQ_LITERAL)?
	  (WITH  PRIVATE  KEY LPAREN  private_key_list RPAREN )?
	;

generate_new_keys
	: ak_password_option? WITH  
		(COMMA ? date_options)*
	;

date_options
	: START_DATE  OPEQ  SQ_LITERAL
	| EXPIRY_DATE  OPEQ  SQ_LITERAL
    | SUBJECT  OPEQ  SQ_LITERAL
	;

// End: create_certificate
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// 
create_contract
	: CONTRACT  keyw_id
		authorization?
		LPAREN 

			contract_element_list
		
		RPAREN 
		
		SEMI ?
	;

contract_element_list
	: contract_element (COMMA  contract_element)*
	;
	
contract_element
	: contract_name contract_by

	;

contract_by
    : SENT  BY  ( INITIATOR | TARGET | ANY)
    ;

contract_name
    : sq_br_literal
    ;

///////////////////////////////////////////////////////////
	
///////////////////////////////////////////////////////////
// create_credential statements
//
create_credential
	: CREDENTIAL  keyw_id WITH  IDENTITY  OPEQ  SQ_LITERAL
		( COMMA  SECRET  OPEQ  SQ_LITERAL)?
		SEMI ?
    ;
// End: create_credential
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// create_database statements
//
create_database
    : DATABASE  keyw_id
		cd_on_clause?
        cd_for_option?
		cd_log_option?
    	cd_collate_clause?
    	cd_with_clause?
        cd_as?
    	SEMI ?
    ;

cd_collate_clause
	: COLLATE  keyw_id COMMA ?
	;

cd_with_clause
	: WITH  cd_ext_access_option+
	;

cd_ext_access_option
    :   (
              (DB_CHAINING | TRUSTWORTHY)  (ON|OFF)
        ) COMMA ?
    ;

cd_on_clause
	: ON 
        (
            PRIMARY?

            db_filespec_list? COMMA ?
            cd_filegroup_list?
        )
;

cd_as
    : AS  cd_snapshot_list
    ;

cd_snapshot_list
	: cs+=cd_snapshot (COMMA cs+=cd_snapshot)* AS SNAPSHOT OF keyw_id

	;

cd_snapshot
	: LPAREN 
		NAME OPEQ  keyw_id COMMA  FILENAME OPEQ  SQ_LITERAL
	  RPAREN 
	;
	
cd_log_option
	: LOG  ON  db_filespec_list COMMA ?
	;
	
cd_filegroup_list
	: cf+=cd_filegroup (COMMA cf+=cd_filegroup)*

	;
	
cd_filegroup
	: FILEGROUP  keyw_id (CONTAINS FILESTREAM)? DEFAULT? db_filespec_list
	;

cd_for_option
	: FOR 
		(
			  ATTACH (WITH  cd_service_broker_option)?
			| ATTACH_REBUILD_LOG
		) COMMA ?
	;

cd_service_broker_option
	: ENABLE_BROKER
	| NEW_BROKER
	| ERROR_BROKER_CONVERSATIONS
	;
// End: create_database
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// create_default statements
// (Deprecated).
//
create_default
	: DEFAULT  keyw_id AS  expression SEMI ?
	;

///////////////////////////////////////////////////////////
// create_endpoint statements
//
create_endpoint
    : ENDPOINT  keyw_id

        authorization?
        ce_state?
    	ce_as?
        ce_for
      
      SEMI ?
    ;

ce_for
    : FOR  cep_languages
    ;


cep_languages
	: cep_soap
	| ep_service_broker
	| ep_database_mirroring
	| TSQL
	;

cep_soap
	: SOAP 
		LPAREN 
			ep_webmethod_list?
		
            (COMMA ? ep_soap_optlist)?
        RPAREN 
	;

ep_webmethod_list
	: ep_webmethod (COMMA  ep_webmethod)*
	;

ep_webmethod
	: WEBMETHOD  SQ_LITERAL (DOT  SQ_LITERAL)?
		ep_wm_params
	;

ce_as
    : AS  cep_protocols
    ;

cep_protocols
	: HTTP 
		LPAREN 
			ep_protocols_http_path
            ep_protocols_http_authentication
			ep_protocols_http_ports
			ep_protocols_http_site?
			ep_protocols_http_clear_port?
			ep_protocols_http_ssl_port?
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


ce_state
    : STATE  OPEQ 
        (
              STARTED
            | STOPPED
            | DISABLED
        )
    ;

// End: create_endpoint
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// create_event statements
//
create_event
	: EVENT  NOTIFICATION  keyw_id
		event_on
		( WITH  FAN_IN)?
	  event_name_for
	  event_to
	  SEMI ?
	;

event_to
    : TO  SERVICE  SQ_LITERAL (COMMA  SQ_LITERAL)?
    ;

event_on
    : ON  (
				  SERVER
				| DATABASE
				| QUEUE keyw_id
			)
    ;

event_name_for
	: FOR  event_name_list
    ;
event_name_list
    : e+=event_name (COMMA e+=event_name)*

	;
		
event_name
	: keyw_id
	;
	
	
// End: create_endpoint
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// create_fulltext statements
//
create_fulltext
    : FULLTEXT 
    	(
	    	  fulltext_catalog

		    | fulltext_index
	    )
	  SEMI ?
    ;

fulltext_catalog
    : CATALOG  keyw_id
        fulltext_filegroup?
        fulltext_path?
        fulltext_accent?
        ( AS  DEFAULT)?
        authorization?
    ;

fulltext_filegroup
    : ON  FILEGROUP  filegroup
    ;

fulltext_path
    : KIN  PATH  SQ_LITERAL
    ;

fulltext_accent
    : WITH  ACCENT_SENSITIVITY  OPEQ  (ON | OFF)
    ;

fulltext_index
    : KINDEX  ON  keyw_id
		        LPAREN 
					fulltext_col (COMMA  fulltext_col)*
		        RPAREN 
		        fulltext_key
				fulltext_change_tracking?
    ;

fulltext_key
    : KEY  KINDEX  keyw_id
					(ON  keyw_id)?
    ;

fulltext_change_tracking
    : WITH  CHANGE_TRACKING  (MANUAL | AUTO | OFF )
		(COMMA  NO POPULATION )?
    ;

// End: create_fulltext
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// create_function statements
//
create_function
	: alter_function
	;

// End: create_function
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// create_index statements
//
create_index
	:	(
		    UNIQUE? (CLUSTERED | NONCLUSTERED | SPATIAL)?
			KINDEX  keyw_id
    		ci_on 
			ci_include?
			ci_with?
			ci_on2?

		 | PRIMARY? ci_xml_index  keyw_id
    		ci_on3
    		ci_xml_index_using?
            ci_xml_index_with?
    	)
    	SEMI ?
    ;

ci_xml_index_with
    : WITH  LPAREN  xml_index_option_list RPAREN 
    ;

ci_xml_index_using
    : USING  XML  KINDEX  keyw_id
    			( FOR  (VALUE | PATH | PROPERTY) )?
    ;
    
ci_xml_index
    : XML KINDEX 
    ;

ci_on3
    : ON  keyw_id LPAREN  keyw_id RPAREN 
    ;

ci_on2
    : ON  (keyw_id | SQ_LITERAL) (LPAREN  keyw_id RPAREN )?
    ;

ci_on
    : ON  keyw_id col_list_paren
    ;

ci_include
    : INCLUDE  col_list_paren
    ;

ci_with
    : WITH 
        
        /* Prior to T-SQL 2005 the parens seem optional */

        (
              LPAREN  relational_index_option_list RPAREN 
            | relational_index_option_list
        )
    ;

col_list_paren
    : LPAREN 
        column_name (ASC|DESC)? (COMMA  column_name (ASC|DESC)?)*
      RPAREN 
    ;

relational_index_option_list
	: r+=relational_index_option (COMMA r+=relational_index_option)*

	;
	
relational_index_option
	: xml_index_option
	| 
		(
			  IGNORE_DUP_KEY
			| ONLINE
		) 
			OPEQ  (ON | OFF)
	;
	
xml_index_option_list
	: xml_index_option (COMMA xml_index_option)*
	;
	
xml_index_option
	: (MAXDOP | FILLFACTOR )  OPEQ  INTEGER
	|
		(
			  PAD_INDEX
			| SORT_IN_TEMPDB
			| STATISTICS_NORECOMPUTE
			| ALLOW_ROW_LOCKS
			| ALLOW_PAGE_LOCKS
			| DROP_EXISTING
		) 
			(OPEQ  (ON | OFF))?
    | table_option // SQL 2008 R2
	;

    
   
// End: create_index
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// create_login statements
//
create_login
    : LOGIN 
    
    	keyw_id		// Login name is NOT delimited (which is stupid but that's what you get
    	cl_from_with
   	
  	  SEMI ?
	;

cl_from_with
    : FROM  login_sources
    | WITH  cl_option_list
    ;


login_sources
		// Note that this allows too many options for WINDOWS - check semantically
		//
	: WINDOWS  (WITH  cl_option (COMMA  cl_option)*)?
	| CERTIFICATE  keyw_id
	| ASYMMETRIC  KEY  keyw_id
	;
	
cl_option_list
	: PASSWORD  OPEQ  SQ_LITERAL HASHED? MUST_CHANGE?
	
			(COMMA  cl_option)*
	;
	
cl_option
	: SID  OPEQ  expression
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
    ;
    
// End: create_login
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// create_master statements
//
create_master
    : MASTER  KEY 
    	ENCRYPTION  BY  PASSWORD  OPEQ  SQ_LITERAL
      SEMI ?
    ;
// End: create_master
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// create_message statements
//
create_message
    : MESSAGE  TYPE  keyw_id_part		// Not allowed to have server or database names
    
		authorization?
    	cm_validation?
    	SEMI ?
    ;

cm_validation
    : VALIDATION 
    	  OPEQ 
    		(
    			  NONE
    			| EMPTY
    			| WELL_FORMED_XML
    			| VALID_XML WITH  SCHEMA  COLLECTION  keyw_id
    		)
    ;

// End: create_message
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// create_partition statements
//
create_partition
    : PARTITION 
		(
    			cp_function
    		|	cp_scheme
    	)
    	SEMI ?
    ;

cp_function
    : FUNCTION  keyw_id LPAREN  data_type RPAREN 
    			AS  RANGE  (LEFT|RIGHT)?
    			FOR  VALUES  LPAREN  expression_list RPAREN 
    ;

cp_scheme
    : SCHEME  keyw_id
        AS  PARTITION  keyw_id
    	ALL? TO  LPAREN 
    					 keyw_id_list	// Spec says PRIMARY must be used here as [PRIMARY]
    					RPAREN 
    ;

// End: create_partition
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// create_procedure statements
//
create_procedure
    : PROCEDURE  keyw_id (SEMI  INTEGER)?
    
    	procedure_param_list?
    	
    	cproc_with?
    	
    	(FOR  REPLICATION)?
    	
    	cproc_as
    	
    ;

cproc_as
    : AS 
    		(
    			  EXTERNAL NAME  keyw_id SEMI ?
    			| unblocked_statements
    		)
    ;

cproc_with
    : WITH  procedure_option_list
    ;

procedure_option_list
	: procedure_option+
	;

procedure_option
	: ENCRYPTION
	| RECOMPILE
	| execute_as_clause
	;
	
procedure_param_list
    : LPAREN  procedure_param_list_body RPAREN 
    | procedure_param_list_body
    ;
    
procedure_param_list_body
	: pp+=procedure_param (COMMA pp+=procedure_param)*

	;    

procedure_param
	: keyw_id_part AS? ct_data_type  procedure_param_default? ( KOUT | OUTPUT)?

	;

procedure_param_default
    : OPEQ  expression
    ;
// End: create_procedure
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// create_queue statements
//
create_queue
    : QUEUE  keyw_id
    
    	queue_element_with?
        queue_on?
    
    	SEMI ?
    ;

queue_on
    : ON  (keyw_id | DEFAULT)
    ;

queue_element_with
    : WITH  queue_element_list
    ;

queue_element_list
	: q+=queue_element (COMMA q+=queue_element)*

	;

queue_element
	: ( RETENTION | KSTATUS )  OPEQ  (ON | OFF)
	|
		ACTIVATION 
		LPAREN 
			(
				  qe_activation_list
				| DROP      // Only for ALTER version really
			)
		RPAREN 
	;

qe_activation_list
	: qe_activation (COMMA  qe_activation)*
	;

qe_activation
	: PROCEDURE_NAME  OPEQ  keyw_id
	| MAX_QUEUE_READERS  OPEQ  INTEGER
    | KSTATUS   OPEQ  (ON | OFF)
	| execute_as_clause
	;
	
// End: create_queue
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// create_remote statements
//
create_remote
    : REMOTE  SERVICE  BINDING  keyw_id
        authorization?
        TO  SERVICE  SQ_LITERAL
    	create_remote_with
 
    	SEMI ?
    ;

create_remote_with
    : WITH 
        (
              remote_user_opt (COMMA  remote_anon_opt)?
            | remote_anon_opt (COMMA  remote_user_opt)?
        )
    ;

remote_user_opt
	: USER  OPEQ  keyw_id_part
	;
	
remote_anon_opt
	: ANONYMOUS  OPEQ  (ON |OFF)
	;
	
// End: create_remote
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// r_role statements
//
create_role
    : ROLE 
    	keyw_id authorization?
    	
    	SEMI ?
    ;
// End: r_role
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// r_route statements
//
create_route
    : ROUTE  keyw_id_part
        authorization?
    	route_with
    	SEMI ?
    ;

route_with
    : WITH  route_option_list
    ;

route_option_list
	: ro+=route_option (COMMA ro+=route_option)*

	;

route_option
    : route_option_element 
    ;

route_option_element
	: (SERVICE_NAME | BROKER_INSTANCE | ADDRESS | MIRROR_ADDRESS) 
		
			OPEQ  SQ_LITERAL
	| LIFETIME  OPEQ  INTEGER
	; 
// End: r_route
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// create_rule statements
//
create_rule
    : RULE  keyw_id AS  search_condition SEMI ?
    ;

// End: create_rule statements

///////////////////////////////////////////////////////////
// create_schema statements
//
create_schema
    : SCHEMA 
    	schema_name_clause
        schema_elements?
    ;

schema_name_clause
    : (
          s=keyw_id a=authorization?
        | a=authorization
      )

    ;

schema_elements
    : se+=schema_element+

    ;

schema_element
    : se=schema_element_item

    ;

schema_element_item
    : CREATE  (create_table | create_view )
    | grant_statement
    | revoke_statement
    | deny_statement
    ;

// End: r_schema
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// create_service statements
//
create_service
    : SERVICE  keyw_id_part
        authorization?
    	cr_service_queue_options
	    contracts?
    	SEMI ?
    ;

contracts
    : LPAREN cn+=cs_contract_name (COMMA cn+=cs_contract_name)* RPAREN

    ;

cs_contract_name
    : sq_br_literal

    ;

cr_service_queue_options
    : ON  QUEUE  q=keyw_id
    ;

// End: create_service
///////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////
// create_statistics statements
//
create_statistics
    : STATISTICS 
        keyw_id
        cs_on
        cs_with?
        SEMI ?
    ;

cs_with
    : WITH 
        (
              FULLSCAN
            | SAMPLE INTEGER (PERCENT | ROWS)
            | cs_stream_list
        )
        (COMMA ? NORECOMPUTE)?
    ;

cs_stream_list
    : s+=cs_stream (COMMA s+=cs_stream)*

    ;

cs_stream
    : STATS_STREAM  OPEQ  keyw_id
    ;

cs_on
    : ON  keyw_id column_list
    ;
   

// End: create_statistics
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// create_symmetric statements
// TODO: restart here
//
create_symmetric
    : SYMMETRIC  KEY  keyw_id 
        authorization?
        create_sym_key_options
        create_sym_encryption
    	SEMI ?
    ;

create_sym_key_options
    : WITH  key_options
    ;

key_options
    : k+=key_option (COMMA k+=key_option)*

    ;

key_option
    : KEY_SOURCE  OPEQ  SQ_LITERAL
    | ALGORITHM  OPEQ  ID
    | IDENTITY_VALUE  OPEQ  SQ_LITERAL
    ;

create_sym_encryption
	: ENCRYPTION  BY  encrypting_mechanisms
	;

encrypting_mechanisms
    : e+=encrypting_mechanism (COMMA e+=encrypting_mechanism)*

    ;

encrypting_mechanism
	: CERTIFICATE  keyw_id
	| PASSWORD  OPEQ  SQ_LITERAL
	| (ASYMMETRIC | SYMMETRIC)  KEY  keyw_id
	;


// End: create_symmetric
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// CREATE SYNONYM
//
create_synonym
    : SYNONYM 
        keyw_id FOR  keyw_id

        SEMI ?
    ;
// End: create_synonym
///////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////
// create_table statements
//
create_table
    : TABLE  keyw_id

        LPAREN 
            ct_col_def_list COMMA ?
        RPAREN 
        ct_partition?
        ct_textimage?
        ct_filestream?
        ct_with?
    	SEMI ?
    ;

ct_filestream
    : FILESTREAM_ON 
        (
            keyw_id
            | DEFAULT
        )
    ;

ct_with
    : WITH 
        LPAREN  table_option_list RPAREN 
    ;

table_option_list
    : t+=table_option (COMMA t+=table_option)*

    ;

table_option
    :     DATA_COMPRESSION OPEQ  (NONE | ROW | PAGE )
          ct_on_partitions?
    ;
    
ct_on_partitions
    : ON  PARTITIONS 
        LPAREN 
            partition_list
        RPAREN 
    ;
partition_list
    : p+=partition_list_el (COMMA p+=partition_list_el)*

    ;

partition_list_el
    : expression (TO  expression)?
    ;

ct_textimage
    : TEXTIMAGE_ON  dq_br_literal
    ;

ct_partition
    : ON 
        (
                  keyw_id (LPAREN  keyw_id RPAREN )?
        )
    ;

ct_col_def_list
    : c+=ct_col_def_list_element (COMMA c+=ct_col_def_list_element)*

    ;

ct_col_def_list_element
    : c=ct_column_definition ct=ct_constraint_list? 
    | ct_constraint_list_el
    ;

ct_constraint_list
    : cc+=ct_constraint_list_el+

    ;
    
ct_constraint_list_el
    : ct=ct_col_table_constraint 
    ;

ct_column_definition
	
	: keyw_id       	// Column name (might be just 'timestamp' or something like that)
        (
              ct_data_type
              ct_collate?
              
            | AS  expression			// Computed
                (PERSISTED )?
               
        )?
	;

ct_constraint_identity
    : IDENTITY  ( LPAREN  OPMINUS? INTEGER COMMA  OPMINUS? INTEGER RPAREN  )? (not_for_replication)?
    ;
    
ct_data_type
    : ct_data 
    ;

ct_data
    : (CURSOR|keyw_id|VARCHAR) ID? VARYING? // (keyw_id (keyw_id)?)?	// type name (can be 'national character varying' for instance)
              ( 
				LPAREN
					( 
						  INTEGER (COMMA  INTEGER)?
						| KMAX
						| (CONTENT | DOCUMENT)? keyw_id
					)
				RPAREN 
			  )?
    ;

ct_collate
    : COLLATE  keyw_id
    ;


ct_col_table_constraint
	: opt_constraint_name?
		(
			  (PRIMARY  KEY  | UNIQUE )
			  	(CLUSTERED | NONCLUSTERED)?
                (ct_table_con_cols)?
			  	ct_con_with?
			  	ct_con_on?
			  
			| opt_foreign_key 
			
				ct_table_con_cols?
                ct_con_references
				
				ct_con_on_delete?
                ct_con_on_update?
                not_for_replication?
			
			| CHECK  not_for_replication? LPAREN  search_condition RPAREN 

            | KNOT? KNULL

            | DEFAULT  expression opt_with_values? (FOR  keyw_id)?

            | ROWGUIDCOL

            | ct_constraint_identity
		)
	;

opt_with_values
    : WITH  VALUES
    ;

opt_constraint_name
    : CONSTRAINT  keyw_id
    ;

opt_foreign_key
    : FOREIGN KEY 
    | 
    ;

ct_con_references
    : REFERENCES 
				keyw_id (ct_table_con_cols)?
    ;
    
ct_table_con_cols
    : LPAREN
				cn+=ct_table_con_col (COMMA cn+=ct_table_con_col)*
	  RPAREN
      
    ;

ct_table_con_col
    : column_name (ASC|DESC)?
    ;

ct_con_on_delete
    : ON  KDELETE  ct_on_options
    ;

ct_con_on_update
    : ON  UPDATE  ct_on_options
    ;

ct_con_on
    : ON 
        keyw_id (LPAREN  keyw_id RPAREN )?
    ;

ct_con_with
    : WITH 
        (
              FILLFACTOR OPEQ  INTEGER
            | LPAREN  index_option_list RPAREN 
        )
    ;

ct_table_constraint_col
	: keyw_id (ASC |DESC)?
	;
    			

ct_on_options
	: NO_ACTION 
	| CASCADE 
	| SET (KNULL | DEFAULT)
	;

// End: create_table
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// create_trigger statements
//
create_trigger
    : TRIGGER 
    
    	keyw_id ON 
    	(
    		  trig_iud
    		| trig_ddl
    	)

    	SEMI ?
    ;

trig_ddl
    : trig_ddl_stuff 
    ;

trig_ddl_stuff
    : (DATABASE | ALL SERVER )
    			(
    				trig_with?

    				(FOR | AFTER)
    						(
    							  LOGON
    							| keyw_id_list
    						)

    				trigger_body
    			)
    ;

trig_iud
    : trig_iud_stuff 
    ;

trig_iud_stuff
    :  keyw_id

    		  trig_with?

    		  ( FOR | AFTER | INSTEAD OF )

    		  trig_del_ins_up_list

              (WITH  APPEND)?
    		  not_for_replication?

				trigger_body
    ;

trig_with
    : WITH  trigger_option_list
    ;

trigger_body
    
	: AS 
		(
    		  unblocked_statements
    		| EXTERNAL NAME keyw_id
    	)
    ;

unblocked_statements
    : begin_statement 
    | statements+ (END |EOF )
    ;

trig_del_ins_up_list
	: t+=trig_del_ins_up (COMMA t+=trig_del_ins_up)*

	;

trig_del_ins_up
	: KDELETE
	| INSERT
	| UPDATE
	;

trigger_option_list
	: t+=trigger_option (COMMA t+=trigger_option)*

	;

trigger_option
	: ENCRYPTION
	| execute_as_clause
	;
	
// End: create_trigger
///////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////
// create_type statements
//
create_type
    : TYPE 
        keyw_id
        (
              cr_type_from
            | external_name
            | AS  TABLE
                LPAREN 
                    ct_col_def_list COMMA ?
                RPAREN 
        )
        SEMI ?
    ;


cr_type_from
    : FROM 
        cr_type_data_type
        (KNULL | KNOT KNULL)?
    ;

cr_type_data_type
    : cr_type_data 
    ;

cr_type_data
    : keyw_id 	// type name
			  ( 
				LPAREN 
					(
						    INTEGER (COMMA  INTEGER)?
                          | ((CONTENT|DOCUMENT))? keyw_id
					
					)
				RPAREN 
			  )?
    ;

// End of create_type
///////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////
// create_user statements
//
create_user
    : USER  keyw_id
        (
              cr_user_for_from
            | WITHOUT LOGIN 
        )

        cr_user_schema?

       SEMI ?
    ;

cr_user_schema
    : WITH  DEFAULT_SCHEMA  OPEQ  keyw_id
    ;
    
cr_user_for_from
    : (FOR|FROM) 

        cr_user_credentials
    ;

cr_user_credentials
    : LOGIN  keyw_id
    | CERTIFICATE  keyw_id
    | ASYMMETRIC  KEY  keyw_id
    ;

// End: create_user
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// create_view statements
//
create_view
    : VIEW 
    		keyw_id column_list?
    		
    		view_with?
    		view_as
    		
    		(WITH  CHECK OPTION )?
    	SEMI ?
    ;

view_as
    : AS  select_statement
    ;

view_with
    : WITH view_attribute_list
    ;

view_attribute_list
	: view_attribute (COMMA  view_attribute)*
	;
	
view_attribute
	: ENCRYPTION
	| SCHEMABINDING
	| VIEW_METADATA
	;
	
// End: create_view
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// create_xml statements
//
create_xml
    : XML  SCHEMA  COLLECTION  keyw_id? AS (SQ_LITERAL |keyw_id)
    	SEMI ?
    ;
// End: create_xml
///////////////////////////////////////////////////////////

