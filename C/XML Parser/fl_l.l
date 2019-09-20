%{
#include "bi_b.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int lineNumber = 1;
%}
%option noyywrap
letter [a-zA-Z]
digit [0-9]
other_characters [./_]
minus [-]
whitespace [ \t]
newline [\n]
string ({letter}|{digit}|{other_characters})({letter}|{digit}|{other_characters})+
boolean true|false
year [0-9999]
month [0-12]
day [1-31]
%%
"ss:Workbook"   {printf("%s", yytext); return WORKBOOK;}
"\/ss:Workbook" {printf("%s", yytext); return CLOSINGWORKBOOK;}
"\/ss:Styles"   {printf("%s", yytext); return CLOSINGSTYLES;}
"ss:Styles"     {printf("%s", yytext); return STYLES;}
"\/ss:Style"    {printf("%s", yytext); return CLOSINGSTYLE;}
"ss:Style"    	{printf("%s", yytext); return STYLE;}
"ss:Worksheet"  {printf("%s", yytext); return WORKSHEET;}
"\/ss:Worksheet" {printf("%s", yytext); return CLOSINGWORKSHEET;}
"ss:Table"	{printf("%s", yytext); return TABLE;}
"ss:ExpandedColumnCount"	{printf("%s", yytext); return EXPANDEDCOLUMNCOUNT;}
"ss:ExpandenRowCount"		{printf("%s", yytext); return EXPANDEDROWCOUNT;}
"ss:StyleID"	{printf("%s", yytext); return STYLEID;}
"\/ss:Table"	{printf("%s", yytext); return CLOSINGTABLE;}
"ss:Column"	{printf("%s", yytext); return COLUMN;}
"ss:Hidden"	{printf("%s", yytext); return HIDDEN;}
"ss:Width"	{printf("%s", yytext); return WIDTH;}
"ss:Row"	{printf("%s", yytext); return ROW;}
"ss:Height"	{printf("%s", yytext); return HEIGHT;}
"\/ss:Row"	{printf("%s", yytext); return CLOSINGROW;}
"ss:Cell"	{printf("%s", yytext); return CELL;}
"\/ss:Cell"	{printf("%s", yytext); return CLOSINGCELL;}
"ss:Data"	{printf("%s", yytext); return DATA;}
"\/ss:Data"	{printf("%s", yytext); return CLOSINGDATA;}
"ss:Type"       {printf("%s", yytext); return TYPE;}
""Boolean""	{printf("%s", yytext); return TYPECHOICEB;}
""Number""	{printf("%s", yytext); return TYPECHOICEN;}
""Datetime""    {printf("%s", yytext); return TYPECHOICED;}
""String"" 	{printf("%s", yytext); return TYPECHOICES;}
{year}"-"{month}"-"{day}	{printf("%s", yytext); return DATETIME;}
{boolean}	{printf("%s", yytext); return BOOLEAN;}
"<"     {printf("%s", yytext); return START;}
">"     {printf("%s", yytext); return CLOSE;}
"\/"     {printf("%s", yytext); return SLASH;} 
"="	{printf("%s", yytext); return EQ;}
{digit}+	{printf("%s", yytext); return POSNUM;}
{string}({whitespace}|{string})*    {printf ("%s", yytext); return KEIMENO;}
"ss:ID"       {printf("%s", yytext); return ID;}
"ss:Name"       {printf("%s", yytext); return NAME;}
{whitespace}        {printf(" "); } /* This is to deal with whitespaces */
{newline}       {printf("\n");lineNumber++; } /*Counting line*/
"<!--"[^-]*"-->"        {printf("%s",yytext); } /* this is to deal with comments */
%% 


