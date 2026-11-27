#!/bin/bash
set -uo pipefail
cd "$(dirname "$0")/.."
export DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer
: "${GF_SIMULATOR_UDID:?Run the whole script through the factory simulator pool}"
tag=${1:-phone}
xcrun simctl boot "$GF_SIMULATOR_UDID" || true
xcrun simctl bootstatus "$GF_SIMULATOR_UDID" -b
xcrun simctl status_bar "$GF_SIMULATOR_UDID" override --time '9:41' --dataNetwork wifi --wifiMode active --wifiBars 3 --batteryState charged --batteryLevel 100
xcodebuild -project ClubCareer.xcodeproj -scheme CairnXI -configuration Develop94 -destination "id=$GF_SIMULATOR_UDID" -parallel-testing-enabled NO -maximum-concurrent-test-simulator-destinations 1 -derivedDataPath Build/DerivedData -resultBundlePath "QA/$tag.xcresult" CODE_SIGNING_ALLOWED=YES CODE_SIGN_IDENTITY=- test > "QA/$tag.log" 2>&1
rc=$?
xcrun xcresulttool export attachments --path "QA/$tag.xcresult" --output-path "QA/$tag-attachments" > "QA/$tag-attachments.log" 2>&1 || true
xcrun xcresulttool get test-results summary --path "QA/$tag.xcresult" > "QA/$tag-summary.json" 2>/dev/null || true
xcrun simctl io "$GF_SIMULATOR_UDID" screenshot "QA/$tag-final.png" || true
container=$(xcrun simctl get_app_container "$GF_SIMULATOR_UDID" com.clubcareer.app data 2>/dev/null) || true
if [ -n "$container" ] && [ -f "$container/Library/Application Support/Cairn94/journey.json" ]; then cp "$container/Library/Application Support/Cairn94/journey.json" "QA/$tag-saved-career.json"; fi
shared=$(xcrun simctl get_app_container "$GF_SIMULATOR_UDID" com.clubcareer.app group.app.lumenpath.clubcareer.ember94 2>/dev/null) || true
if [ -n "$shared" ] && [ -f "$shared/widget-career.json" ]; then
 cp "$shared/widget-career.json" "QA/$tag-widget-cache.json"
 cmp "QA/$tag-widget-cache.json" "QA/$tag-saved-career.json" > "QA/$tag-cache-comparison.txt" || rc=1
else
 echo "App Group snapshot unavailable" > "QA/$tag-cache-comparison.txt"
 rc=1
fi
python3 QA/collect.py || true
exit "$rc"
