# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

PATH=.:$PATH:$HOME/.local/bin

# Java
JAVA_HOME=$HOME/Javasoft/jdk
# CLASSPATH=.:$JAVA_HOME/jre/lib/rt.jar
ANT_HOME=$HOME/Javasoft/ant

PATH=$JAVA_HOME/bin:$PATH:$ANT_HOME/bin

# Maven
M2_HOME=$HOME/Javasoft/apache-maven
M2=$M2_HOME/bin
MAVEN_OPTS="-Xms256m -Xmx512m"
PATH=$PATH:$M2

# Antlr4
ANTLR4_HOME=$HOME/Devel/Libs/antlr4
# CLASSPATH=$CLASSPATH:$ANTLR4_HOME/antlr-complete.jar

# GNAT/Ada
GNAT_HOME=$HOME/GNAT/gnat
PATH=$PATH:$GNAT_HOME/bin

# LLVM
LLVM_HOME=$HOME/Cppsoft/clang
PATH=$PATH:$LLVM_HOME/bin

# CMAKE
PATH=$PATH:$HOME/Devel/Libs/cmake/bin

# Haskell
# PATH=$PATH:$HOME/.cabal/bin:/opt/cabal/1.24/bin:/opt/ghc/8.0.2/bin:/opt/happy/1.19.5/bin:/opt/alex/3.1.7/bin

# TMPDIR=$HOME/tmp
# R
# R_LIBS_USER=/home/kongra/R/x86_64-pc-linux-gnu-library/3.2/

# MATHEMATICA
PATH=$PATH:$HOME/Mathematica/8.0/bin

IBUS_ENABLE_SYNC_MODE=1

# PHP/composer
PATH=$PATH:$HOME/.composer/vendor/bin

# Rust/cargo
PATH=$PATH:$HOME/.cargo/bin

export PATH JAVA_HOME ANT_HOME M2_HOME M2 MAVEN_OPTS ANTLR4_HOME GNAT_HOME LLVM_HOME IBUS_ENABLE_SYNC_MODE
