import os
from os.path import join

flags = [
'-Wall',
'-Wextra',
'-Werror',
'-Wc++98-compat',
'-Wno-long-long',
'-Wno-variadic-macros',
'-fexceptions',
'-DNDEBUG',
# std=c++11 or std=c99.
'-std=c++11',
# For a C project, you would set this to 'c' instead of 'c++'.
'-x', 'c++',
]

if os.uname()[0] == 'Darwin':
    # Given by gcc -x c++ -v -E /dev/null
    # and gcc -x c -v -E /dev/null
    XcodeRoot='/Applications/Xcode.app/Contents/Developer'
    XcodeToolchainRoot=join(XcodeRoot, 'Toolchains/XcodeDefault.xctoolchain')
    XcodePlatformRoot=join(XcodeRoot, 'Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.11.sdk')

    xcode_header_dirs = [
         join(XcodeToolchainRoot, 'usr/bin/../include/c++/v1'),
         join(XcodeToolchainRoot, 'usr/include'),
         join(XcodeToolchainRoot, 'usr/bin/../lib/clang/7.0.0/include'),
         join(XcodePlatformRoot, 'usr/include')]

    for h in xcode_header_dirs:
        flags.extend(('-isystem', h))

def DirectoryOfThisScript():
  return os.path.dirname( os.path.abspath( __file__ ) )


def MakeRelativePathsInFlagsAbsolute( flags, working_directory ):
  if not working_directory:
    return list( flags )
  new_flags = []
  make_next_absolute = False
  path_flags = [ '-isystem', '-I', '-iquote', '--sysroot=' ]
  for flag in flags:
    new_flag = flag

    if make_next_absolute:
      make_next_absolute = False
      if not flag.startswith( '/' ):
        new_flag = os.path.join( working_directory, flag )

    for path_flag in path_flags:
      if flag == path_flag:
        make_next_absolute = True
        break

      if flag.startswith( path_flag ):
        path = flag[ len( path_flag ): ]
        new_flag = path_flag + os.path.join( working_directory, path )
        break

    if new_flag:
      new_flags.append( new_flag )
  return new_flags


def IsHeaderFile( filename ):
  extension = os.path.splitext( filename )[ 1 ]
  return extension in [ '.h', '.hxx', '.hpp', '.hh' ]


def GetCompilationInfoForFile( filename ):
  # The compilation_commands.json file generated by CMake does not have entries
  # for header files. So we do our best by asking the db for flags for a
  # corresponding source file, if any. If one exists, the flags for that file
  # should be good enough.
  if IsHeaderFile( filename ):
    basename = os.path.splitext( filename )[ 0 ]
    for extension in SOURCE_EXTENSIONS:
      replacement_file = basename + extension
      if os.path.exists( replacement_file ):
        compilation_info = database.GetCompilationInfoForFile(
          replacement_file )
        if compilation_info.compiler_flags_:
          return compilation_info
    return None
  return database.GetCompilationInfoForFile( filename )


def FlagsForFile( filename, **kwargs ):
    relative_to = DirectoryOfThisScript()
    final_flags = MakeRelativePathsInFlagsAbsolute( flags, relative_to )

    return {
        'flags': final_flags,
        'do_cache': True }