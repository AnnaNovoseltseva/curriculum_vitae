#!/bin/bash

INTERACTION=nonstopmode
OUTDIR=dist
JOBNAME_PREFIX=resume

usage() { echo "Usage: $0 [-v]" 1>&2; exit 1; }

log() {
	if [ -n "${VERBOSE}" ]; then 
		echo $1
	fi
}

while getopts "v" o; do
	case "${o}" in
		v)
			VERBOSE=true
			;;
		*)
			usage
			;;
	esac
done
shift $((OPTIND-1))

rm -rf $OUTDIR
mkdir -p $OUTDIR

echo "Compiling resume into resume.pdf ..."

xelatex --interaction=${INTERACTION} -output-directory=${OUTDIR} -jobname=${JOBNAME_PREFIX} main.tex &>/dev/null

log "Done."

echo "Removing build files..."

rm ${OUTDIR}/*.{aux,log,out}

log "Done."

exit 0
