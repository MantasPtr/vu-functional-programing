{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_test_project (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/usr/local/bin"
libdir     = "/usr/local/lib/x86_64-linux-ghc-8.4.3/test-project-0.1.0.0-7VCof1MvqGELfqCRv3D4v7"
dynlibdir  = "/usr/local/lib/x86_64-linux-ghc-8.4.3"
datadir    = "/usr/local/share/x86_64-linux-ghc-8.4.3/test-project-0.1.0.0"
libexecdir = "/usr/local/libexec/x86_64-linux-ghc-8.4.3/test-project-0.1.0.0"
sysconfdir = "/usr/local/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "test_project_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "test_project_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "test_project_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "test_project_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "test_project_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "test_project_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
