// いいねのajax処理。全体的に酷すぎるのでちゃんとサーバーと通信して実値を出すようにする

document.addEventListener('turbolinks:load', function(){
  document.querySelectorAll('.fav-btn').forEach(function(div){
    div.addEventListener('ajax:success', function(){
      var a = div.firstElementChild;
      var i = a.childNodes[0];
      var num = a.childNodes[1];
      var flash = div.childNodes[1];
      a.classList.toggle('faved');

      var n;
      if(num.innerText){
        n = parseInt(num.innerText);
      }else{
        n = 0;
      }

      if(i.classList.contains('fa-heart')){
        i.classList.replace('fa-heart', 'fa-heart-o');
        a.setAttribute('data-method', 'post');
        flash.classList.remove('faved-flash')
        flash.innerText = '';
        n--;
        if(n){
          num.innerText = n;
        }else{
          num.innerText = "";
        }
      }else{
        i.classList.replace('fa-heart-o', 'fa-heart');
        a.setAttribute('data-method', 'delete');
        //flash.innerText = 'いいねしました！';
        flash.classList.add('faved-flash');
        n++;
        num.innerText = n;
      }
    })
  });
});
