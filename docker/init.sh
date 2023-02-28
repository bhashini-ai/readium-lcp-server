echo "START ENV SUBSTITUTION" && envsubst < /tmp/config.yaml > /config.yaml && echo "END ENV SUBSTITUTION"

# Update base href of frontend index.html
if [ -n "$2" ]
then
  sed -i "s@base href=\"/\"@base href=\"${BASE_URL}\"@g" $2/index.html
fi

mkdir -p $LCP_DATABASE_ROOT_PATH
mkdir -p $LCP_STORAGE_PATH
mkdir -p $FRONTEND_MASTER_PATH
mkdir -p $FRONTEND_ENCRYPTED_PATH

echo "exec $1"
exec $1
