#!/bin/sh

count() {  # args...
	echo $#
}

which combine >/dev/null 2>&1 || {
	echo "error: Missing 'combine' utility" >&2
	exit 2
}

which adb >/dev/null 2>&1 || {
	echo "error: Missing Android Debug Bridge (adb)" >&2
	exit 2
}

[ -e ".photosync" ] || touch ".photosync" || {
	echo "error: Cannot create sync file" >&2
	exit 2
}

directory="$(date +'%Y%m%d%H%M')"
mkdir -p "${directory}"

deviceFiles="$(adb -d shell ls -1A '/storage/emulated/0/DCIM/Camera/')"
unsyncedFiles=$(echo "$deviceFiles" | combine - not ".photosync")
unsyncedFiles=$(echo $unsyncedFiles)

i=0
numFiles=$(count $unsyncedFiles)
errors=0

[ $numFiles -eq 0 ] && {
	echo "Nothing to sync." >&2
	exit 0
}

echo "Syncing ${numFiles} files" >&2
echo >&2

for filename in $unsyncedFiles; do
	percentage=$(( (i * 100) / numFiles ))
	printf "[ %3s%% ] " "${percentage}"
	echo "Pulling ${filename}"
	adb -d pull -p -a "/storage/emulated/0/DCIM/Camera/${filename}" "${directory}/${filename}" \
		&& { echo "${filename}" >> ".photosync"; } \
		|| (( errors++ ))
	(( i++ ))
done

percentage=$(( (i * 100) / numFiles ))
printf "[ %3s%% ] " "${percentage}"
echo "Done"

if [ $errors -eq 0 ]; then
	echo "Completed without errors." >&2
else
	echo "${errors} errors occurred during sync." >&2
	exit 3
fi
