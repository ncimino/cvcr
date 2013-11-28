$(document).ready(function(){
  //$( 'body' ).removeClass( 'active_admin' );
  //var CKEDITOR_BASEPATH = 'http://cdnjs.cloudflare.com/ajax/libs/ckeditor/4.0.1/';
  //$.getScript( '//cdnjs.cloudflare.com/ajax/libs/ckeditor/4.2/ckeditor.js' , function() {
  $.getScript( '//cdnjs.cloudflare.com/ajax/libs/ckeditor/4.0.1/ckeditor.js' , function() {
  //$( 'body' ).removeClass( 'active_admin' );
    if ( $('#ckeditor').length ) {
      CKEDITOR.replace( 'ckeditor',
      {
        height: '500px'
      });
      //if ( $('#cke_ckeditor').length ) $('#ckeditor').css('margin-left','20%');
      if ( $('#ckeditor').prev('label').length ) $('#ckeditor').prev('label').css('float','none');
          //.attr('float', 'none');
    }
  });
});