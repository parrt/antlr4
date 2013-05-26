/** Converted by Terence Parr to ANTLR v4 */

/* This file is part of the Java 1.7 grammar for SableCC.
 *
 * Copyright 2006,2012 Etienne M. Gagnon <egagnon@j-meg.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

grammar JavaSable;

  // 3.8

  // 3.9

  // 3.11

  java_compilation_unit :
    compilation_unit;

  // 3.10

  literal :
     IntegerLiteral |
     FloatingPointLiteral |
     BooleanLiteral |
     CharacterLiteral |
     StringLiteral |
     'null';

  // 4.1

  type :
     primitive_type |
     reference_type;

  // 4.2

  primitive_type :
     numeric_type |
     'boolean';

  numeric_type :
     integral_type |
     floating_point_type;

  integral_type :
     'byte' |
     'short' |
     'int' |
     'long' |
     'char';

  floating_point_type :
     'float' |
     'double';

  // 4.3

  reference_type :
     ((type_name | class_or_interface_type ('.') Identifier) type_arguments?) |
     ((type_name | class_or_interface_type ('.') Identifier) type_arguments?) |
     type_variable |
     array_type;

  class_or_interface_type :
     ((type_name | class_or_interface_type ('.') Identifier) type_arguments?) |
     ((type_name | class_or_interface_type ('.') Identifier) type_arguments?);

  type_decl_specifier :
     type_name |
     class_or_interface_type ('.') Identifier;

  // defined differently in 6.5
  //
  // type_name :
  //    Identifier |
  //    type_name dot Identifier;

  type_variable :
    Identifier;

  array_type :
    type '[' ']';

  // 4.4

  type_parameter :
    type_variable type_bound?;

  type_bound :
     'extends' type_variable |
     'extends' class_or_interface_type additional_bound_list?;

  additional_bound_list :
     additional_bound additional_bound_list |
     additional_bound;

  additional_bound :
    '&' (type_decl_specifier type_arguments?);

  // 4.5

  type_arguments :
    '<' type_argument_list '>';

  type_argument_list :
     type_argument |
     type_argument_list ',' type_argument;

  type_argument :
     reference_type |
     wildcard;

  wildcard :
    '?' wildcard_bounds?;

  wildcard_bounds :
     'extends' reference_type |
     'super' reference_type;

  // 6.5

  package_name :
     Identifier |
     package_name ('.') Identifier;

  type_name :
     Identifier |
     package_or_type_name ('.') Identifier;

  expression_name :
     Identifier |
     ambiguous_name ('.') Identifier;

  method_name :
     Identifier |
     ambiguous_name ('.') Identifier;

  package_or_type_name :
     Identifier |
     package_or_type_name ('.') Identifier;

  ambiguous_name :
     Identifier |
     ambiguous_name ('.') Identifier;

  // 7.3

  compilation_unit :
    package_declaration? import_declarations? type_declarations?;

  import_declarations :
     import_declaration |
     import_declarations import_declaration;

  type_declarations :
     type_declaration |
     type_declarations type_declaration;

  // 7.4

  package_declaration :
    annotations? 'package' package_name ';';

  // 7.5

  import_declaration :
     single_type_import_declaration |
     type_import_on_demand_declaration |
     single_static_import_declaration |
     static_import_on_demand_declaration;

  single_type_import_declaration :
    'import' type_name ';';

  type_import_on_demand_declaration :
    'import' package_or_type_name ('.') '*' ';';

  single_static_import_declaration :
    'import' 'static' type_name ('.') Identifier ';';

  static_import_on_demand_declaration :
    'import' 'static' type_name ('.') '*' ';';

  // 7.6

  type_declaration :
     class_declaration |
     interface_declaration |
     ';';

  // 8.1

  class_declaration :
     normal_class_declaration |
     enum_declaration;

  normal_class_declaration :
    class_modifiers? 'class' Identifier type_parameters? super? interfaces? class_body;

  class_modifiers :
     class_modifier |
     class_modifiers class_modifier;

  class_modifier :
     annotation |
     'public' |
     'protected' |
     'private' |
     'abstract' |
     'static' |
     'final' |
     'strictfp';

  type_parameters :
    '<' type_parameter_list '>';

  type_parameter_list :
     type_parameter_list ',' type_parameter |
     type_parameter;

  super :
    'extends' (type_decl_specifier type_arguments?);

  interfaces :
    'implements' interface_type_list;

  interface_type_list :
     (type_decl_specifier type_arguments?) |
     interface_type_list ',' (type_decl_specifier type_arguments?);

  class_body :
    '{' class_body_declarations? '}';

  class_body_declarations :
     class_body_declaration |
     class_body_declarations class_body_declaration;

  class_body_declaration :
     class_member_declaration |
     instance_initializer |
     static_initializer |
     constructor_declaration;

  class_member_declaration :
     field_declaration |
     method_declaration |
     class_declaration |
     interface_declaration |
     ';';

  // 8.3

  field_declaration :
    field_modifiers? type variable_declarators ';';

  variable_declarators :
     variable_declarator |
     variable_declarators ',' variable_declarator;

  variable_declarator :
     variable_declarator_id |
     variable_declarator_id ':' variable_initializer;

  variable_declarator_id :
     Identifier |
     variable_declarator_id '[' ']';

  variable_initializer :
     expression |
     array_initializer;

  field_modifiers :
     field_modifier |
     field_modifiers field_modifier;

  field_modifier :
     annotation |
     'public' |
     'protected' |
     'private' |
     'static' |
     'final' |
     'transient' |
     'volatile';

  // 8.4

  method_declaration :
    method_header method_body;

  method_header :
    method_modifiers? type_parameters? result method_declarator throws_?;

  method_declarator :
     Identifier '(' formal_parameter_list? ')' |
     method_declarator '[' ']';

  formal_parameter_list :
     last_formal_parameter |
     formal_parameters ',' last_formal_parameter;

  formal_parameters :
     formal_parameter |
     formal_parameters ',' formal_parameter;

  formal_parameter :
    variable_modifiers? type variable_declarator_id;

  variable_modifiers :
     variable_modifier |
     variable_modifiers variable_modifier;

  variable_modifier :
     annotation |
     'final';

  last_formal_parameter :
     variable_modifiers? type '...' variable_declarator_id |
     formal_parameter;

  method_modifiers :
     method_modifier |
     method_modifiers method_modifier;

  method_modifier :
     annotation |
     'public' |
     'protected' |
     'private' |
     'abstract' |
     'static' |
     'final' |
     'synchronized' |
     'native' |
     'strictfp';

  result :
     type |
     'void';

  throws_ :
    'throws' exception_type_list;

  exception_type_list :
     exception_type |
     exception_type_list ',' exception_type;

  exception_type :
     type_name |
     type_variable;

  method_body :
     block |
     ';';


  // 8.6

  instance_initializer :
    block;

  // 8.7

  static_initializer :
    'static' block;

  // 8.8

  constructor_declaration :
    constructor_modifiers? constructor_declarator throws_? constructor_body;

  constructor_declarator :
    type_parameters? simple_type_name '(' formal_parameter_list? ')';

  // Missing from JLS

  simple_type_name :
    Identifier;

  constructor_modifiers :
     constructor_modifier |
     constructor_modifiers constructor_modifier;

  constructor_modifier :
     annotation |
     'public' |
     'protected' |
     'private';

  constructor_body :
    '{' explicit_constructor_invocation? block_statements? '}';

  explicit_constructor_invocation :
     non_wild_type_arguments? 'this' '(' argument_list? ')' ';' |
     non_wild_type_arguments? 'super' '(' argument_list? ')' ';' |
     primary ('.') non_wild_type_arguments? 'super' '(' argument_list? ')' ';';

  non_wild_type_arguments :
    '<' reference_type_list '>';

  reference_type_list :
     reference_type |
     reference_type_list ',' reference_type;

  // 8.9

  enum_declaration :
    class_modifiers? 'enum' Identifier interfaces? enum_body;

  enum_body :
    '{' enum_constants? ','? enum_body_declarations? '}';

  enum_constants :
     enum_constant |
     enum_constants ',' enum_constant;

  enum_constant :
    annotations? Identifier arguments? class_body?;

  arguments :
    '(' argument_list? ')';

  enum_body_declarations :
    ';' class_body_declarations?;

  // 9.1

  interface_declaration :
     normal_interface_declaration |
     annotation_type_declaration;

  // Includes correction to erroneous split in two alternatives in JLS

  normal_interface_declaration :
    interface_modifiers? 'interface' Identifier type_parameters? extends_interfaces? interface_body;

  interface_modifiers :
     interface_modifier |
     interface_modifiers interface_modifier;

  interface_modifier :
     annotation |
     'public' |
     'protected' |
     'private' |
     'abstract' |
     'static' |
     'strictfp';

  extends_interfaces :
    'extends' interface_type_list;

  interface_body :
    '{' interface_member_declarations? '}';

  interface_member_declarations :
     interface_member_declaration |
     interface_member_declarations interface_member_declaration;

  interface_member_declaration :
      constant_declaration |
      abstract_method_declaration |
      class_declaration |
      interface_declaration |
      ';';

  // 9.3

  constant_declaration :
    constant_modifiers? type variable_declarators ';';

  constant_modifiers :
     constant_modifier |
     constant_modifiers constant_modifier;

  constant_modifier :
     annotation |
     'public' |
     'static' |
     'final';

  // 9.4

  abstract_method_declaration :
    abstract_method_modifiers? type_parameters? result method_declarator throws_? ';';

  abstract_method_modifiers :
     abstract_method_modifier |
     abstract_method_modifiers abstract_method_modifier;

  abstract_method_modifier :
     annotation |
     'public' |
     'abstract';

  // 9.6

  annotation_type_declaration :
    interface_modifiers? '@' 'interface' Identifier annotation_type_body;

  annotation_type_body :
    '{' annotation_type_element_declarations? '}';

  annotation_type_element_declarations :
     annotation_type_element_declaration |
     annotation_type_element_declarations annotation_type_element_declaration;

  annotation_type_element_declaration :
     abstract_method_modifiers? type Identifier '(' ')' dims? default_value? ';' |
     constant_declaration |
     class_declaration |
     interface_declaration |
     enum_declaration |
     annotation_type_declaration |
     ';';

  default_value :
    'default' element_value;

  // 9.7

  annotations :
     annotation |
     annotations annotation;

  annotation :
     normal_annotation |
     marker_annotation |
     single_element_annotation;

  normal_annotation :
    '@' type_name '(' element_value_pairs? ')';

  element_value_pairs :
     element_value_pair |
     element_value_pairs ',' element_value_pair;

  element_value_pair :
    Identifier ':' element_value;

  element_value :
     conditional_expression |
     annotation |
     element_value_array_initializer;

  element_value_array_initializer :
    '{' element_values? ','? '}';

  element_values :
     element_value |
     element_values ',' element_value;

  marker_annotation :
    '@' Identifier;

  single_element_annotation :
    '@' Identifier '(' element_value ')';

  // 10.6

  array_initializer :
    '[' variable_initializers? ','? ']';

  variable_initializers :
     variable_initializer |
     variable_initializers ',' variable_initializer;

  // 14.2

  block :
    '{' block_statements? '}';

  block_statements :
     block_statement |
     block_statements block_statement;

  block_statement :
     local_variable_declaration_statement |
     class_declaration |
     statement;

  // 14.4

  local_variable_declaration_statement :
    local_variable_declaration ';';

  local_variable_declaration :
    variable_modifiers? type variable_declarators;

  // 14.5

  statement :
     statement_without_trailing_substatement |
     labeled_statement |
     if_then_statement |
     if_then_else_statement |
     while_statement |
     for_statement;

  statement_without_trailing_substatement :
     block |
     empty_statement |
     expression_statement |
     assert_statement |
     switch_statement |
     do_statement |
     break_statement |
     continue_statement |
     return_statement |
     synchronized_statement |
     throw_statement |
     try_statement;

  statement_no_short_if :
     statement_without_trailing_substatement |
     labeled_statement_no_short_if |
     if_then_else_statement_no_short_if |
     while_statement_no_short_if |
     for_statement_no_short_if;

  // 14.6

  empty_statement :
    ';';

  // 14.7

  labeled_statement :
    Identifier ':' statement;

  labeled_statement_no_short_if :
    Identifier ':' statement_no_short_if;

  // 14.8

  expression_statement :
    statement_expression ';';

  statement_expression :
     assignment |
     pre_increment_expression |
     pre_decrement_expression |
     post_increment_expression |
     post_decrement_expression |
     method_invocation |
     class_instance_creation_expression;

  // 14.9

  if_then_statement :
    'if' '(' expression ')' statement;

  if_then_else_statement :
    'if' '(' expression ')' statement_no_short_if 'else' statement;

  if_then_else_statement_no_short_if :
    'if' '(' expression ')' statement_no_short_if 'else' statement_no_short_if;

  // 14.10

  assert_statement :
     'assert' expression ';' |
     'assert' expression ':' expression ';';

  // 14.11

  switch_statement :
    'switch' '(' expression ')' switch_block;

  switch_block :
    '{' switch_block_statement_groups? switch_labels? '}';

  switch_block_statement_groups :
     switch_block_statement_group |
     switch_block_statement_groups switch_block_statement_group;

  switch_block_statement_group :
    switch_labels block_statements;

  switch_labels :
     switch_label |
     switch_labels switch_label;

  switch_label :
     'case' constant_expression ':' |
     'case' enum_constant_name ':' |
     'default' ':';

  enum_constant_name :
    Identifier;

  // 14.12

  while_statement :
    'while' '(' expression ')' statement;

  while_statement_no_short_if :
    'while' '(' expression ')' statement_no_short_if;

  // 14.13

  do_statement :
    'do' statement 'while' '(' expression ')' ';';

  // 14.4

  for_statement :
     basic_for_statement |
     enhanced_for_statement;

  basic_for_statement :
    'for' '(' for_init? ';' expression? ';' for_update? ')' statement;

  for_statement_no_short_if :
    'for' '(' for_init? ';' expression? ';' for_update? ')' statement_no_short_if;

  for_init :
     statement_expression_list |
     local_variable_declaration;

  for_update :
    statement_expression_list;

  statement_expression_list :
     statement_expression |
     statement_expression_list ',' statement_expression;

  enhanced_for_statement :
    'for' '(' formal_parameter ':' expression ')' statement;

  // 14.15

  break_statement :
    'break' Identifier? ';';

  // 14.16

  continue_statement :
    'continue' Identifier? ';';

  // 14.17

  return_statement :
    'return' expression? ';';

  // 14.18

  throw_statement :
    'throw' expression ';';

  // 14.19

  synchronized_statement :
    'synchronized' '(' expression ')' block;

  // 14.20

  try_statement :
     'try' block catches |
     'try' block catches? finally_ |
     try_with_resources_statement;

  catches :
     catch_clause |
     catches catch_clause;

  catch_clause :
    'catch' '(' catch_formal_parameter ')' block;

  catch_formal_parameter :
    variable_modifiers? catch_type variable_declarator_id;

  catch_type :
     (type_decl_specifier type_arguments?) |
     (type_decl_specifier type_arguments?) '|' catch_type;

  finally_ :
    'finally' block;

  try_with_resources_statement :
    'try' resource_specification block variable_declarator_id catches? finally_?;

  resource_specification :
    '(' resources ';'? ')';

  resources :
     resource |
     resource ';' resources;

  resource :
    variable_modifiers? type variable_declarator_id ':' expression;

  // 15.8

  primary :
     primary_no_new_array |
     array_creation_expression;

  primary_no_new_array :
     literal |
     type '.' 'class' |
     'void' '.' 'class' |
     'this' |
     class_name '.' 'this' |
     '(' expression ')' |
     class_instance_creation_expression |
     field_access |
     method_invocation |
     array_access;

  // Missing from JLS

  class_name :
    type_name;

  // 15.9

  class_instance_creation_expression :
     'new' type_arguments? type_decl_specifier type_arguments_or_diamond? '(' argument_list? ')' class_body? |
     primary '.' 'new' type_arguments? Identifier type_arguments_or_diamond? '(' argument_list? ')' class_body?;

  type_arguments_or_diamond :
     type_arguments |
     '<' '>';

  argument_list :
     expression |
     argument_list ',' expression;

  // 15.10

  array_creation_expression :
     'new' primitive_type dim_exprs dims? |
     'new' class_or_interface_type dim_exprs dims? |
     'new' primitive_type dims array_initializer |
     'new' class_or_interface_type dims array_initializer;

  dim_exprs :
     dim_expr |
     dim_exprs dim_expr;

  dim_expr :
    '[' expression ']';

  dims :
     '[' ']' |
     dims '[' ']';

  // 15.11

  field_access :
     primary '.' Identifier |
     'super' '.' Identifier |
     class_name '.' 'super' '.' Identifier;

  // 15.12

  method_invocation :
     method_name '(' argument_list? ')' |
     primary '.' non_wild_type_arguments? Identifier '(' argument_list? ')' |
     'super' '.' non_wild_type_arguments? Identifier '(' argument_list? ')' |
     class_name '.' 'super' '.' non_wild_type_arguments? Identifier '(' argument_list? ')' |
     type_name '.' non_wild_type_arguments Identifier '(' argument_list? ')';

  // 15.13

  array_access :
     expression_name '[' expression ']' |
     primary_no_new_array '[' expression ']';

  // 15.14

  postfix_expression :
     primary |
     expression_name |
     post_increment_expression |
     post_decrement_expression;

  post_increment_expression :
    postfix_expression '++';

  post_decrement_expression :
    postfix_expression '--';

  // 15.15

  unary_expression :
    pre_increment_expression |
    pre_decrement_expression |
    '+' unary_expression |
    '-' unary_expression |
    unary_expression_not_plus_minus;

  pre_increment_expression :
    '++' unary_expression;

  pre_decrement_expression :
    '--' unary_expression;

  unary_expression_not_plus_minus :
     postfix_expression |
     '~' unary_expression |
     '!' unary_expression |
     cast_expression;

  // 15.16

  cast_expression :
     '(' primitive_type ')' unary_expression |
     '(' reference_type ')' unary_expression_not_plus_minus;

  // 15.17

  multiplicative_expression :
     unary_expression |
     multiplicative_expression '*' unary_expression |
     multiplicative_expression '/' unary_expression |
     multiplicative_expression '%' unary_expression;

  // 15.18

  additive_expression :
     multiplicative_expression |
     additive_expression '+' multiplicative_expression |
     additive_expression '-' multiplicative_expression;

  // 15.19

  shift_expression :
     additive_expression |
     shift_expression '<<' additive_expression |
     shift_expression '>>' additive_expression |
     shift_expression '>>>' additive_expression;

  // 15.20

  relational_expression :
         shift_expression |
     relational_expression '<' shift_expression |
     relational_expression '>' shift_expression |
     relational_expression '<=' shift_expression |
     relational_expression '>=' shift_expression |
     relational_expression 'instanceof' reference_type;

  // 15.21

  equality_expression :
     relational_expression |
     equality_expression '==' relational_expression |
     equality_expression '!=' relational_expression;

  // 15.22

  and_expression :
     equality_expression |
     and_expression '&' equality_expression;

  exclusive_or_expression :
     and_expression |
     exclusive_or_expression '^' and_expression;

  inclusive_or_expression :
     exclusive_or_expression |
     inclusive_or_expression '|' exclusive_or_expression;

  // 15.23

  conditional_and_expression :
     inclusive_or_expression |
     conditional_and_expression '&&' inclusive_or_expression;

  // 15.24

  conditional_or_expression :
     conditional_and_expression |
     conditional_or_expression '||' conditional_and_expression;

  // 15.25

  conditional_expression :
     conditional_or_expression |
     conditional_or_expression '?' expression ':' conditional_expression;

  // 15.26

  assignment_expression :
     conditional_expression |
     assignment;

  assignment :
    left_hand_side assignment_operator assignment_expression;

  left_hand_side :
     expression_name |
     field_access |
     array_access;

  assignment_operator :
     ':' |
     '*=' |
     '/=' |
     '%=' |
     '+=' |
     '-=' |
     '<<=' |
     '>>=' |
     '>>>=' |
     '&=' |
     '^=' |
     '|='
                      ;

  // 15.27

  expression :
    assignment_expression;

  // 15.28

  constant_expression :
    expression;

// Copied from ANTLR v4 Java lexer rules
  
  IntegerLiteral
	:	DecimalIntegerLiteral
	|	HexIntegerLiteral
	|	OctalIntegerLiteral
	|	BinaryIntegerLiteral
	;

fragment
DecimalIntegerLiteral
	:	DecimalNumeral IntegerTypeSuffix?
	;

fragment
HexIntegerLiteral
	:	HexNumeral IntegerTypeSuffix?
	;

fragment
OctalIntegerLiteral
	:	OctalNumeral IntegerTypeSuffix?
	;

fragment
BinaryIntegerLiteral
	:	BinaryNumeral IntegerTypeSuffix?
	;

fragment
IntegerTypeSuffix
	:	[lL]
	;

fragment
DecimalNumeral
	:	'0'
	|	NonZeroDigit (Digits? | Underscores Digits)
	;

fragment
Digits
	:	Digit (DigitsAndUnderscores? Digit)?
	;

fragment
Digit
	:	'0'
	|	NonZeroDigit
	;

fragment
NonZeroDigit
	:	[1-9]
	;

fragment
DigitsAndUnderscores
	:	DigitOrUnderscore+
	;

fragment
DigitOrUnderscore
	:	Digit
	|	'_'
	;

fragment
Underscores
	:	'_'+
	;

fragment
HexNumeral
	:	'0' [xX] HexDigits
	;

fragment
HexDigits
	:	HexDigit (HexDigitsAndUnderscores? HexDigit)?
	;

fragment
HexDigit
	:	[0-9a-fA-F]
	;

fragment
HexDigitsAndUnderscores
	:	HexDigitOrUnderscore+
	;

fragment
HexDigitOrUnderscore
	:	HexDigit
	|	'_'
	;

fragment
OctalNumeral
	:	'0' Underscores? OctalDigits
	;

fragment
OctalDigits
	:	OctalDigit (OctalDigitsAndUnderscores? OctalDigit)?
	;

fragment
OctalDigit
	:	[0-7]
	;

fragment
OctalDigitsAndUnderscores
	:	OctalDigitOrUnderscore+
	;

fragment
OctalDigitOrUnderscore
	:	OctalDigit
	|	'_'
	;

fragment
BinaryNumeral
	:	'0' [bB] BinaryDigits
	;

fragment
BinaryDigits
	:	BinaryDigit (BinaryDigitsAndUnderscores? BinaryDigit)?
	;

fragment
BinaryDigit
	:	[01]
	;

fragment
BinaryDigitsAndUnderscores
	:	BinaryDigitOrUnderscore+
	;

fragment
BinaryDigitOrUnderscore
	:	BinaryDigit
	|	'_'
	;

// §3.10.2 Floating-Point Literals

FloatingPointLiteral
	:	DecimalFloatingPointLiteral
	|	HexadecimalFloatingPointLiteral
	;

fragment
DecimalFloatingPointLiteral
	:	Digits '.' Digits? ExponentPart? FloatTypeSuffix?
	|	'.' Digits ExponentPart? FloatTypeSuffix?
	|	Digits ExponentPart FloatTypeSuffix?
	|	Digits FloatTypeSuffix
	;

fragment
ExponentPart
	:	ExponentIndicator SignedInteger
	;

fragment
ExponentIndicator
	:	[eE]
	;

fragment
SignedInteger
	:	Sign? Digits
	;

fragment
Sign
	:	[+-]
	;

fragment
FloatTypeSuffix
	:	[fFdD]
	;

fragment
HexadecimalFloatingPointLiteral
	:	HexSignificand BinaryExponent FloatTypeSuffix?
	;

fragment
HexSignificand
	:	HexNumeral '.'?
	|	'0' [xX] HexDigits? '.' HexDigits
	;

fragment
BinaryExponent
	:	BinaryExponentIndicator SignedInteger
	;

fragment
BinaryExponentIndicator
	:	[pP]
	;

// §3.10.3 Boolean Literals

BooleanLiteral
	:	'true'
	|	'false'
	;

// §3.10.4 Character Literals

CharacterLiteral
	:	'\'' SingleCharacter '\''
	|	'\'' EscapeSequence '\''
	;

fragment
SingleCharacter
	:	~['\\]
	;

// §3.10.5 String Literals

StringLiteral
	:	'"' StringCharacters? '"'
	;

fragment
StringCharacters
	:	StringCharacter+
	;

fragment
StringCharacter
	:	~["\\]
	|	EscapeSequence
	;

// §3.10.6 Escape Sequences for Character and String Literals

fragment
EscapeSequence
	:	'\\' [btnfr"'\\]
	|	OctalEscape
    |   UnicodeEscape
	;

fragment
OctalEscape
	:	'\\' OctalDigit
	|	'\\' OctalDigit OctalDigit
	|	'\\' ZeroToThree OctalDigit OctalDigit
	;

fragment
UnicodeEscape
    :   '\\' 'u' HexDigit HexDigit HexDigit HexDigit
    ;

fragment
ZeroToThree
	:	[0-3]
	;

Identifier
	:	JavaLetter JavaLetterOrDigit*
	;

fragment
JavaLetter
	:	[a-zA-Z$_] // these are the "java letters" below 0xFF
	|	// covers all characters above 0xFF which are not a surrogate
		~[\u0000-\u00FF\uD800-\uDBFF]
		{Character.isJavaIdentifierStart(_input.LA(-1))}?
	|	// covers UTF-16 surrogate pairs encodings for U+10000 to U+10FFFF
		[\uD800-\uDBFF] [\uDC00-\uDFFF]
		{Character.isJavaIdentifierStart(Character.toCodePoint((char)_input.LA(-2), (char)_input.LA(-1)))}?
	;

fragment
JavaLetterOrDigit
	:	[a-zA-Z0-9$_] // these are the "java letters or digits" below 0xFF
	|	// covers all characters above 0xFF which are not a surrogate
		~[\u0000-\u00FF\uD800-\uDBFF]
		{Character.isJavaIdentifierPart(_input.LA(-1))}?
	|	// covers UTF-16 surrogate pairs encodings for U+10000 to U+10FFFF
		[\uD800-\uDBFF] [\uDC00-\uDFFF]
		{Character.isJavaIdentifierPart(Character.toCodePoint((char)_input.LA(-2), (char)_input.LA(-1)))}?
	;
