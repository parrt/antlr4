/**
 * This grammar contains all statements that deal with cursors other than
 * CREATE cursor
 */
parser grammar tsqlcursors;

///////////////////////////////////////////////////////////
// DDL statements that control cursors
//
 cursor_ddl
    : deallocate
    ;
// End: Cursor DDL
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
//
//
cursor_statements
    : fetch_statement
    ;

// End:
///////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////
// Cursor deallocate statement
//
deallocate
    : DEALLOCATE 
        (GLOBAL)? keyw_id

        SEMI ?
    ;

// End: Cursor deallocate
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// cursor declaration (triggered from DECLARE parsing in tsqlmisc)
//
declare_cursor_pred
    : keyw_id INSENSITIVE? SCROLL? CURSOR
    ;

declare_cursor
    : keyw_id i=INSENSITIVE? s=SCROLL? CURSOR ( i=INSENSITIVE)? ( s=SCROLL)?

        common_cursor_decl?

    ;

common_cursor_decl
    :   (LOCAL|GLOBAL)?
        dc_extended_options
        dc_for_statement
        dc_for_options?
    ;

dc_for_options
    : FOR  dc_for_option
    ;

dc_for_option
    : READ ONLY 
    | UPDATE  (OF  keyw_id_list)?
    ;

dc_extended_options
    : (FORWARD_ONLY | SCROLL)?
      ( STATIC | KEYSET | DYNAMIC | FAST_FORWARD)?
      ( READ_ONLY | SCROLL_LOCKS | OPTIMISTIC)?
      TYPE_WARNING?
    ;

dc_for_statement
    : FOR  select_statement
    ;
    
// End:
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// FETCH statement
//
fetch_statement
    : FETCH 
        
        ( fetch_opts | )
        FROM ?
        fetch_global
        fetch_into?

        SEMI ?
    ;

fetch_opts_pred
    : NEXT
    | PRIOR
    | FIRST
    | LAST
    | ABSOLUTE
    | RELATIVE
    ;

fetch_opts
    : NEXT
    | PRIOR
    | FIRST
    | LAST
    | (ABSOLUTE|RELATIVE)  (OPMINUS? INTEGER | keyw_id)
    ;

fetch_global
    : (GLOBAL)? keyw_id
    ;

fetch_into
    : INTO  keyw_id_list
    ;

// End: FETCH statement
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// OPEN cursor
//
open_cursor
    : (GLOBAL)? keyw_id
    ;

// End:
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
//
//

// End:
///////////////////////////////////////////////////////////
