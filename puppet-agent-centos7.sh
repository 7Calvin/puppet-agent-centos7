echo "Iniciando a instalacao....."

yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum -y install https://yum.puppet.com/puppet-release-el-7.noarch.rpm
yum install puppet-agent -y



echo "Configurando a instalacao....."

cat <<EOF >> /etc/puppetlabs/puppet/puppet.conf
[agent]
    server = foreman.calvin.local
    certname = $HOSTNAME
    runinterval = 180
    environment = production
    listen = false
    pluginsync = true
    report = true
EOF

sudo /opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true
service puppet restart
/opt/puppetlabs/bin/puppet agent -t

echo "Finalizado a instalacao"
