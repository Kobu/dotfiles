TOKEN=$(cat ~/utils/.clerk-token)
DATA=$(curl -s -X GET \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  "https://nowaster-web-production.up.railway.app/api/session/fixed/active")

if [ "$DATA" = "" ] || [ "$DATA" = "null" ] ; then
    echo ""
    exit 1
fi

format () {
    date --date=$1 +"%H:%M"
}

if [ "$(echo $DATA | jq ".data")" = "[]" ]; then
    echo ""
    exit 0
fi

CAT=$(echo $DATA | jq ".data.[0].category.name" | tr -d '"')
START=$(format $(echo $DATA | jq ".data.[0].startTime" | tr -d '"'))
END=$(format $(echo $DATA | jq ".data.[0].endTime" | tr -d '"'))
TAGS=$(echo $DATA | jq "[.data[].tags[].label] | unique | join(\", \") | \"(\" + . + \")\"" | tr -d '[]"')

# if  end is null then show start time and how many minutes ago it was
if [ "$END" = "" ]; then
    # set end as now
    END=$(date +"%H:%M")
    let DIFF=($(date +%s -d $END)-$(date +%s -d $START))/60
    echo "[${CAT}] $TAGS: ${START}->now (${DIFF}mins)"
    exit 0
fi

let DIFF=($(date +%s -d $END)-$(date +%s))/60
echo "[${CAT}] $TAGS: ${START}->${END} (${DIFF}mins)"
