
const router = require('express').Router();


router.get('/', (req, res) => {
  console.log('Req response: ');
  return res.send('Hello wordl!');
});

module.exports = router;
