const express= require('express');
const app=express();
app.get('/home',(req,res)=>{
  return  res.json({message:'home page'});
});
app.listen(3000,()=>{
    console.log("server is running");
})