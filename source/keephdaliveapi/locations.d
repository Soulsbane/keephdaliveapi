module keephdaliveapi.locations;

import std.algorithm;
import std.file : readText;
import std.stdio;
import std.string : splitLines;

struct Locations
{
	void loadFile(const string fileName) @safe
	{
		locationsFileName_ = fileName;
		loadString(fileName.readText());
	}

	void loadString(const string data) pure @safe
	{
		data.splitLines
			.each!(line => insert(line));
	}

	void saveFile() @safe
	{
		saveFile(locationsFileName_);
	}

	void saveFile(const string fileName) @safe
	{
		auto file = File(fileName, "w+");
		locations_.each!(location => file.writeln(location));
	}

	void insert(const string location) nothrow pure @safe
	{
		locations_ ~= location;
	}

	void remove(const string location) nothrow pure @safe
	{
		import darrayutils : remove;
		locations_.remove(location);
	}

	void removeAll(const string location) nothrow pure @safe
	{
		import darrayutils : removeAll;
		locations_.removeAll(location);
	}

	void clear() nothrow pure @safe
	{
		locations_ = [];
	}

	size_t length() nothrow pure @safe
	{
		return locations_.length;
	}

	bool exists(const string path) nothrow const pure @safe
	{
		return locations_.canFind(path);
	}

	@property bool empty() const nothrow pure @safe
	{
		return locations_.length == 0;
	}

	@property ref string front() nothrow pure @safe
	{
		return locations_[0];
	}

	void popFront() nothrow pure @safe
	{
		locations_ = locations_[1 .. $];
	}

	@property ref string back() nothrow pure @safe
	{
		return locations_[$ - 1];
	}

	void popBack() nothrow pure @safe
	{
		locations_ = locations_[0 .. $ - 1];
	}

	string opIndex(size_t index) nothrow pure @safe
	{
		return locations_[index];
	}

	@property Locations save() nothrow pure @safe
	{
		return this;
	}

	string[] getLocations() nothrow pure @safe
	{
		return locations_;
	}

private:
	string[] locations_;
	string locationsFileName_;
}

unittest
{
	import dshould;

	Locations locations;
	locations.insert("Paul");
	locations.insert("Mom");
	locations.insert("Ben");
	locations.insert("Tisha");

	locations.front.should.equal("Paul");
	locations.popFront();
	locations.front.should.equal("Mom");

	locations.back.should.equal("Tisha");
	locations.popBack();
	locations.back.should.equal("Ben");
	locations[0].should.equal("Mom");

	locations.length.should.equal(2);
	locations.clear();
	locations.length.should.equal(0);
}
