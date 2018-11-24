{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_battleships (
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

bindir     = "/home/mape/.cabal/bin"
libdir     = "/home/mape/.cabal/lib/x86_64-linux-ghc-8.0.2/battleships-0.1.0.0-Ad0srY7Mj7pDoZAkHAqOEg"
dynlibdir  = "/home/mape/.cabal/lib/x86_64-linux-ghc-8.0.2"
datadir    = "/home/mape/.cabal/share/x86_64-linux-ghc-8.0.2/battleships-0.1.0.0"
libexecdir = "/home/mape/.cabal/libexec"
sysconfdir = "/home/mape/.cabal/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "battleships_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "battleships_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "battleships_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "battleships_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "battleships_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "battleships_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
