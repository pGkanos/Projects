/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_BI_B_TAB_H_INCLUDED
# define YY_YY_BI_B_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    KEIMENO = 258,
    WORKBOOK = 259,
    CLOSINGWORKBOOK = 260,
    STYLES = 261,
    STYLE = 262,
    CLOSINGSTYLE = 263,
    CLOSINGSTYLES = 264,
    WORKSHEET = 265,
    CLOSINGWORKSHEET = 266,
    BOOLEAN = 267,
    TABLE = 268,
    CLOSINGTABLE = 269,
    POSNUM = 270,
    COLUMN = 271,
    ROW = 272,
    CLOSINGROW = 273,
    CELL = 274,
    CLOSINGCELL = 275,
    DATA = 276,
    CLOSINGDATA = 277,
    START = 278,
    CLOSE = 279,
    SLASH = 280,
    ID = 281,
    NAME = 282,
    PROTECTED = 283,
    EXPANDEDCOLUMNCOUNT = 284,
    EXPANDEDROWCOUNT = 285,
    HIDDEN = 286,
    WIDTH = 287,
    STYLEID = 288,
    HEIGHT = 289,
    MERGEACROSS = 290,
    MERGEDOWN = 291,
    TYPE = 292,
    DATETIME = 293,
    TYPECHOICEB = 294,
    TYPECHOICES = 295,
    TYPECHOICEN = 296,
    TYPECHOICED = 297,
    EQ = 298
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_BI_B_TAB_H_INCLUDED  */
