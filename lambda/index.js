const getRandom = () => `00000000${Math.round(Math.random() * 99999999)}`.substr(-8, 8)
const Lambda = getRandom()

exports.handler = async (_event, _context, callback) => callback(null, {
  statusCode: 200,
  body: JSON.stringify({lambda: Lambda, random: getRandom()})
})
