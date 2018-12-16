var qrcode = require('qrcode-terminal');
var fs = require('fs');
fs.readFile('sebs.js', 'utf8', function (err, data) {
  if (err) throw err;
     node = JSON.parse(data);
    console.log('-----------------iOS小火箭链接--------------------')
    console.log(ios(node).toString())
    console.log('-----------------安卓 v2rayNG链接-----------------')
    console.log(android(node).toString())
    console.log('-----------------iOS 小火箭二维码------------------')
    qrcode.generate(ios(node).toString(), {small: true},function (qrcode) {
    console.log(qrcode);
});
});
function ios(node) {
    !node.method ? node.method = 'chacha20-poly1305' : ''
    let v2rayBase = '' + node.method + ':' + node.id + '@' + node.add + ':' + node.port
    let remarks = ''
    // let obfsParam = ''
    let path = ''
    let obfs = ''
    let tls = ''
    !node.ps ? remarks = 'remarks=oneSubscribe' : remarks = `remarks=${node.ps}`
    !node.path ? '' : path = `&path=${node.path}`
    node.net == 'ws' ? obfs = `&obfs=websocket` : ''
    node.net == 'h2' ? obfs = `&obfs=http` : ''
    node.tls == 'tls' ? tls = `&tls=1` : ''
    let query = remarks + path + obfs + tls
    let baseV2ray = Buffer.from(v2rayBase).toString('base64')
    let server = Buffer.from('vmess://' + baseV2ray + '?' + query)
    return server
}

function android(node) {
    node.v = "2"
    // node.path = node.path.replace(/\//, '')
    delete node.method
    let baseV2ray = Buffer.from(JSON.stringify(node)).toString('base64')
    let server = Buffer.from('vmess://' + baseV2ray)
    return server
}

