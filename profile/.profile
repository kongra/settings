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

PATH=.:$PATH

# SBCL
SBCL_HOME=$HOME/SBCL/lib/sbcl
# PATH=$PATH:$HOME/SBCL/bin

# Java
JAVA_HOME=$HOME/Javasoft/jdk
CLASSPATH=.:$JAVA_HOME/jre/lib/rt.jar
ANT_HOME=$HOME/Javasoft/ant

PATH=$JAVA_HOME/bin:$PATH:$ANT_HOME/bin

# Maven
M2_HOME=$HOME/Javasoft/apache-maven
M2=$M2_HOME/bin
MAVEN_OPTS="-Xms256m -Xmx512m"
PATH=$PATH:$M2

# Clojure and LAN project
# CLOJURE_SRC=$HOME/Devel/Libs/clojure-1.1/src
# CLASSPATH=$CLASSPATH:$CLOJURE_SRC/clj:$CLOJURE_SRC/jvm

# CLOJURE_CONTRIB_SRC=$HOME/Devel/Libs/clojure-contrib-1.1/src
# CLASSPATH=$CLASSPATH:$CLOJURE_CONTRIB_SRC

# LAN_SRC=$HOME/Devel/Projects/LAN/src
# CLASSPATH=$CLASSPATH:$LAN_SRC/clj-src:$LAN_SRC/java-src

# JRuby
# PATH=$PATH:$HOME/Javasoft/jruby/bin

# Python
PYTHONPATH=.:$HOME/Devel/Projects/Python

# Python virtualenv
VENV=~/virtualenv

# ALTERNATE_EDITOR=emacs
# EDITOR=emacsclient -t
# VISUAL=emacsclient -t

# Haskell
PATH=$PATH:$HOME/.cabal/bin:/opt/cabal/1.20/bin:/opt/ghc/7.8.3/bin:/opt/happy/1.19.3/bin:/opt/alex/3.1.3/bin

export SBCL_HOME PATH JAVA_HOME ANT_HOME M2_HOME M2 MAVEN_OPTS CLASSPATH LAN_SRC CLOJURE_SRC CLOJURE_CONTRIB_SRC PYTHONPATH ALTERNATE_EDITOR EDITOR VISUAL VENV

export LANGUAGE="pl:en"
export LC_MESSAGES="pl_PL.UTF-8"
export LC_CTYPE="pl_PL.UTF-8"
export LC_COLLATE="pl_PL.UTF-8"
