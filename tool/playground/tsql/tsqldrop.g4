/**
 * This grammar contains all the syntax for parsing DROP statements
 */
parser grammar tsqldrop;

///////////////////////////////////////////////////////////
// All forms of the DROP statement
//
drop_statement
    : DROP 

        (
              dropCommon        // Things that are the same syntax with a different keyword
            | dropCommonList    // Things that are list of things to drop but otherwise the same
            | dropAssembly
            | dropEvent
            | dropFullText
            | dropIndex
            | dropMasterKey
            | dropPartition
            | dropSignature
            | dropTrigger
        )
    ;
// End: DROP statement
///////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////
// Common form of DROP statement DROP KEYWORD name
//
dropCommon
    : dropElements  keyw_id

        SEMI ?
    ;

dropElements
    : AGGREGATE
    | APPLICATION ROLE 
    | (SYMMETRIC | ASYMMETRIC) KEY 
    | CERTIFICATE
    | CONTRACT
    | CREDENTIAL
    | ENDPOINT
    | LOGIN
    | MESSAGE TYPE 
    | QUEUE
    | REMOTE SERVICE  BINDING 
    | ROLE
    | ROUTE
    | SCHEMA
    | SERVICE
    | SYNONYM
    | TYPE
    | USER
    | XML SCHEMA  COLLECTION 
;

// End: Common DROP format
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// Common form of dropping a list of things
//
dropCommonList
    : dropListElements  keyw_id_list

        SEMI ?
    ;

dropListElements
    : DATABASE
    | DEFAULT
    | FUNCTION
    | PROCEDURE
    | RULE
    | STATISTICS
    | TABLE
    | VIEW
    ;
// End:
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
//
//
dropAssembly
    : ASSEMBLY  keyw_id_list

        (WITH  NO DEPENDENTS )?

        SEMI ?
    ;

// End:
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// DROP EVENT
//
dropEvent
    : EVENT  NOTIFICATION  keyw_id_list

        dropEventOn

        SEMI ?
    ;

dropEventOn
    : ON 
        (
              SERVER
            | DATABASE
            | QUEUE keyw_id
        )
    ;
    
// End:
///////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////
// DROP FULLTEXT
//
dropFullText
    : FULLTEXT  (CATALOG | KINDEX ON ) keyw_id

        SEMI ?
    ;

// End: DROP FULLTEXT
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// DROP INDEX
//
dropIndex
    : KINDEX 

        (COMMA ? dropIndexOnWith)+

        SEMI ?
    ;

dropIndexOnWith
    : keyw_id (ON  keyw_id column_list? dropIndexWith?)?
    ;

dropIndexWith
    : WITH 
        LPAREN  dropClusteredIndexOptionList RPAREN 
    ;

dropClusteredIndexOptionList
    : d+=dropClusteredIndexOption (COMMA d+=dropClusteredIndexOption)*

    ;

dropClusteredIndexOption
    : MAXDOP  OPEQ  INTEGER
    | ONLINE  OPEQ  (ON|OFF)
    | MOVE  TO 
        (
              keyw_id (LPAREN  keyw_id RPAREN )?
        )
    ;
// End: DROP INDEX
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// DROP MASTER KEY
//
dropMasterKey
    : MASTER KEY
    ;
// End: DROP MASTER KEY
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// DROP PARTITION
//
dropPartition
    : PARTITION  (FUNCTION|SCHEME) keyw_id

        SEMI ?
    ;
// End:
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// DROP SIGNATURE
//
dropSignature
    : COUNTER? SIGNATURE  FROM  keyw_id
        dropSignatureCrypto

        SEMI ?
    ;

dropSignatureCrypto
    : BY  cryptoList
    ;

cryptoList
    : c+=crypto (COMMA c+=crypto)*

    ;

crypto
    : CERTIFICATE  keyw_id
    | ASYMMETRIC  KEY  keyw_id
    ;

// End: DROP SIGNATURE
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// DROP TRIGGER
//
dropTrigger
    : TRIGGER  keyw_id_list

        dropTriggerOn?
    ;

dropTriggerOn
    : ON 

        (
              DATABASE
            | ALL SERVER
        )
    ;
// End:
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
//
//

// End:
///////////////////////////////////////////////////////////


