OLD_BUILDID=0
if [ -f "/steamcmd/rust/build.id" ]; then
	OLD_BUILDID="$(cat /steamcmd/rust/build.id)"
fi

STRING_SIZE=${#RUST_UPDATE_BRANCH}
if [ "$STRING_SIZE" -lt "1" ]; then
	RUST_UPDATE_BRANCH=public
fi

if [ -f "/app/Steam/appcache/appinfo.vdf" ]; then
	rm -fr /app/Steam/appcache/appinfo.vdf
fi

NEW_BUILDID="$(./steamcmd/steamcmd.sh +login anonymous +app_info_update 1 +app_info_print "258550" +quit | grep -EA 1000 "^\s+\"branches\"$" | grep -EA 5 "^\s+\"$RUST_UPDATE_BRANCH\"$" | grep -m 1 -EB 10 "^\s+}$" | grep -E "^\s+\"buildid\"\s+" | tr '[:blank:]"' ' ' | tr -s ' ' | sed "s/ buildid //g" | xargs)"

STRING_SIZE=${#NEW_BUILDID}
if [ "$STRING_SIZE" -lt "6" ]; then
	echo "Error getting latest server build id from Steam.."
	exit
fi

# Skip update checking if this is the first time
if [ ! -f "/steamcmd/rust/build.id" ]; then
	echo "First time running update check (server build id not found), skipping update.."
	echo $NEW_BUILDID > /steamcmd/rust/build.id
	exit
else
	STRING_SIZE=${#OLD_BUILDID}
	if [ "$STRING_SIZE" -lt "6" ]; then
		echo "First time running update check (server build id empty), skipping update.."
		echo $NEW_BUILDID > /steamcmd/rust/build.id
		exit
	fi
fi

# Check if the builds match and quit if so
if [ "$OLD_BUILDID" = "$NEW_BUILDID" ]; then
	echo "Build id $OLD_BUILDID is already the latest, skipping update.."
	exit
else
	# Use a lock file to determine if we're already checking for updates
	if ! mkdir /tmp/restart_app.lock; then
	    echo "Failed to acquire lock"
	    exit 1
	fi
	
	echo "Latest server build id ($NEW_BUILDID) is newer than the current one ($OLD_BUILDID), waiting for client update.."
  echo "Latest server build id ($NEW_BUILDID) is newer than the current one ($OLD_BUILDID), waiting for client update.."
  echo "Latest server build id ($NEW_BUILDID) is newer than the current one ($OLD_BUILDID), waiting for client update.."
  echo "Latest server build id ($NEW_BUILDID) is newer than the current one ($OLD_BUILDID), waiting for client update.."
  echo "Latest server build id ($NEW_BUILDID) is newer than the current one ($OLD_BUILDID), waiting for client update.."
  echo "Latest server build id ($NEW_BUILDID) is newer than the current one ($OLD_BUILDID), waiting for client update.."
	echo $NEW_BUILDID > /steamcmd/rust/build.id
 
fi
