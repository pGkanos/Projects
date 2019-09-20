%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
int errorCount = 0; 
extern int lineNumber;
int yylex();
void yyerror(char *);
extern FILE *yyin;
extern FILE *yyout;
%}
%start WorkbookElement
%token KEIMENO
%token WORKBOOK
%token CLOSINGWORKBOOK
%token STYLES
%token STYLE
%token CLOSINGSTYLE
%token CLOSINGSTYLES
%token WORKSHEET
%token CLOSINGWORKSHEET
%token BOOLEAN 
%token TABLE
%token CLOSINGTABLE
%token POSNUM
%token COLUMN
%token ROW
%token CLOSINGROW
%token CELL
%token CLOSINGCELL
%token DATA
%token CLOSINGDATA
%token START
%token CLOSE
%token SLASH
%token ID
%token NAME
%token PROTECTED
%token EXPANDEDCOLUMNCOUNT
%token EXPANDEDROWCOUNT
%token HIDDEN 
%token WIDTH 
%token STYLEID
%token HEIGHT
%token MERGEACROSS 
%token MERGEDOWN
%token TYPE
%token DATETIME
%token TYPECHOICEB
%token TYPECHOICES
%token TYPECHOICEN
%token TYPECHOICED
%token EQ
%%
text : KEIMENO | ;
DatacontextS : text Dataelement;
DatacontextB : BOOLEAN Dataelement;
DatacontextD : DATETIME Dataelement;
DatacontextN : POSNUM Dataelement;
Dataelement : START DATA TYPE EQ TYPECHOICEB CLOSE DatacontextB 
	    | START DATA TYPE EQ TYPECHOICES CLOSE DatacontextS 
	    | START DATA TYPE EQ TYPECHOICEN CLOSE DatacontextN 
	    | START DATA TYPE EQ TYPECHOICED CLOSE DatacontextD 
	    | START CLOSINGDATA CLOSE Dataelement
	    | START CLOSINGDATA CLOSE Cellcontext;
Cellcontext : Dataelement | Cellelement ;
Cellelement : START CELL MERGEACROSS EQ POSNUM MERGEDOWN EQ POSNUM STYLEID EQ KEIMENO CLOSE Cellcontext 
	    | START CELL MERGEACROSS EQ POSNUM MERGEDOWN EQ POSNUM CLOSE Cellcontext 
	    | START CELL MERGEACROSS EQ POSNUM STYLEID EQ KEIMENO CLOSE Cellcontext
	    | START CELL MERGEDOWN EQ POSNUM STYLEID EQ KEIMENO CLOSE Cellcontext 
	    | START CELL MERGEACROSS EQ POSNUM CLOSE Cellcontext 
	    | START CELL MERGEDOWN EQ POSNUM CLOSE Cellcontext 
	    | START CELL STYLEID EQ KEIMENO CLOSE Cellcontext 
	    | START CELL CLOSE Dataelement 
            | START CLOSINGCELL CLOSE Rowelement ;
Rowcontext : Cellelement | ;
Rowelement : START ROW HEIGHT EQ POSNUM HIDDEN EQ BOOLEAN STYLEID EQ KEIMENO CLOSE Rowcontext
	   | START ROW HEIGHT EQ POSNUM HIDDEN EQ BOOLEAN CLOSE Rowcontext 
           | START ROW HEIGHT EQ POSNUM STYLEID EQ KEIMENO CLOSE Rowcontext 
           | START ROW HIDDEN EQ BOOLEAN STYLEID EQ KEIMENO CLOSE Rowcontext 
           | START ROW HEIGHT EQ POSNUM CLOSE Rowcontext 
           | START ROW HIDDEN EQ BOOLEAN CLOSE Rowcontext  
           | START ROW STYLEID EQ KEIMENO CLOSE Rowcontext 
           | START ROW CLOSE Rowcontext 
	   | START CLOSINGROW CLOSE Rowelement
           | START CLOSINGROW CLOSE Tableelement ;
Columnelement : START COLUMN HIDDEN EQ BOOLEAN WIDTH EQ POSNUM STYLEID EQ KEIMENO SLASH CLOSE Tablecontext
	      | START COLUMN HIDDEN EQ BOOLEAN WIDTH EQ POSNUM SLASH CLOSE Tablecontext
              | START COLUMN HIDDEN EQ BOOLEAN STYLEID EQ KEIMENO SLASH CLOSE Tablecontext
              | START COLUMN WIDTH EQ POSNUM STYLEID EQ KEIMENO SLASH CLOSE Tablecontext
              | START COLUMN HIDDEN EQ BOOLEAN SLASH CLOSE Tablecontext
              | START COLUMN WIDTH EQ POSNUM SLASH CLOSE Tablecontext
              | START COLUMN STYLEID EQ KEIMENO SLASH CLOSE Tablecontext
              | START COLUMN SLASH CLOSE Tablecontext ; 
Tablecontext : Columnelement
	     | Rowelement
	     | Tableelement ; 
Tableelement : START TABLE EXPANDEDCOLUMNCOUNT EQ POSNUM EXPANDEDROWCOUNT EQ POSNUM STYLEID EQ KEIMENO CLOSE Tablecontext 
	     | START TABLE EXPANDEDCOLUMNCOUNT EQ POSNUM STYLEID EQ KEIMENO CLOSE Tablecontext 
	     | START TABLE EXPANDEDROWCOUNT EQ POSNUM STYLEID EQ KEIMENO CLOSE Tablecontext 
             | START TABLE EXPANDEDCOLUMNCOUNT EQ POSNUM EXPANDEDROWCOUNT EQ POSNUM CLOSE Tablecontext
             | START TABLE EXPANDEDCOLUMNCOUNT EQ POSNUM CLOSE Tablecontext
             | START TABLE EXPANDEDROWCOUNT EQ POSNUM CLOSE Tablecontext 
             | START TABLE STYLEID EQ KEIMENO CLOSE Tablecontext 
             | START TABLE CLOSE Tablecontext
	     | START CLOSINGTABLE CLOSE WorksheetElement ;
Worksheetcontext : Tableelement | ;
WorksheetElement : START WORKSHEET NAME EQ KEIMENO CLOSE Worksheetcontext
		 | START WORKSHEET NAME EQ KEIMENO PROTECTED EQ BOOLEAN CLOSE Worksheetcontext
                 | START CLOSINGWORKSHEET CLOSE WorkbookElement ;
StyleElement : START STYLE ID EQ KEIMENO CLOSE START CLOSINGSTYLE CLOSE | StyleElement START STYLE ID EQ KEIMENO CLOSE START CLOSINGSTYLE CLOSE StylesElement ;
Stylescontext : StyleElement ;
StylesElement : START STYLES CLOSE Stylescontext | START CLOSINGSTYLES CLOSE WorksheetElement ;
Workbookcontext : StylesElement 
		| WorksheetElement 
WorkbookElement : START WORKBOOK CLOSE Workbookcontext | START CLOSINGWORKBOOK CLOSE ;
%%
void yyerror (char *s)
{
    errorCount++;
    fprintf(stderr,"%s on line %d \n",s,lineNumber); /*here I get the info about errors */
}

int main(int argc, const char **argv)
{
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
    } else {
        yyin = stdin;
    }

    int result;

    if ((result = yyparse()) == 0) {   
        printf("No syntax errors\n");
    } else {
        printf("\nFound %d syntax errors\n",errorCount);
    }

    return 0;
}
