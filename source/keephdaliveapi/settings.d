module keephdaliveapi.settings;

import ctoptions;
import dpathutils;
import keephdaliveapi.constants;

private struct Options
{
	size_t delay = DEFAULT_FILE_WRITE_DELAY;
	string filename = DEFAULT_WRITE_TO_FILENAME;
	string path;
}

class KeepAliveSettings
{
	// TODO: Mabye use a lock file?
	this()
	{
		path_ = ConfigPath(COMPANY_NAME, PROGRAM_NAME);
	}

private:
	StructOptions!Options settings_;
	ConfigPath path_;
}

unittest
{
	KeepAliveSettings settings = new KeepAliveSettings;
}
