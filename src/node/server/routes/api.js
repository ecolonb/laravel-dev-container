
const router = require('express').Router();
const {tesFunction} = require("../controllers/test")

router.get('/', (req, res) => {
  console.log('Req response: ');
  return res.send('Hello world fro api!');
});

router.get('/all', (req, res)=>{
    console.log("all")
    return res.json({ok:true})
});
router.post('/test', tesFunction);

module.exports = router;
