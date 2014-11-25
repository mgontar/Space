// stdafx.h : include file for standard system include files,
// or project specific include files that are used frequently, but
// are changed infrequently
//

#pragma once

#include <stdio.h>


struct periods
{
	short start,end;
	periods *next;
};

struct StructWord
{
	char c;
	StructWord *next;
	StructWord *prev;
};

class DictWord
{
public:
	DictWord(short n, char* DictChar);
	~DictWord();
	int Add();
	char* GetString(bool Heading);
private:
	StructWord SWord;
	StructWord *Current;
	StructWord *Head;
	StructWord *Tale;

	char* CharBase;
	int CharBaseLength;
	bool PureAdd;
};

class DictCreator 
{
public:
	DictCreator(periods* range);
	bool Open(const char* DictName);
	void Close();
	void Work(int n, int nn);
private:
	FILE* DictFile;
	char BaseDict[255];
	char* Dict;
};



// TODO: reference additional headers your program requires here
