exports.handler = async (_event, _context, callback) => {
  callback(null, {
    statusCode: 200,
    body: JSON.stringify({random: Math.round(Math.random() * 999999)})
  });
}
