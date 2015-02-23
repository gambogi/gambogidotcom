module Paths_gambogidotcom (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch


version :: Version
version = Version {versionBranch = [0,1,0,0], versionTags = []}
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/gambogi/docs/gambogidotcom/.cabal-sandbox/bin"
libdir     = "/home/gambogi/docs/gambogidotcom/.cabal-sandbox/lib/x86_64-linux-ghc-7.8.2/gambogidotcom-0.1.0.0"
datadir    = "/home/gambogi/docs/gambogidotcom/.cabal-sandbox/share/x86_64-linux-ghc-7.8.2/gambogidotcom-0.1.0.0"
libexecdir = "/home/gambogi/docs/gambogidotcom/.cabal-sandbox/libexec"
sysconfdir = "/home/gambogi/docs/gambogidotcom/.cabal-sandbox/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "gambogidotcom_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "gambogidotcom_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "gambogidotcom_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "gambogidotcom_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "gambogidotcom_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
