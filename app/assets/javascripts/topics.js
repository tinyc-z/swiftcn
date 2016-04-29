// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
window._topic_ = 
{
  runPreview : function() {
    var replyContent = $("#reply_content");
    var oldContent = replyContent.val();
    if (oldContent) {
        $('#preview-box').show()
        marked(oldContent, function (err, content) {
          $('#preview-box').html(content);
          // emojify.run(document.getElementById('preview-box'));
        });
    }else{
      $('#preview-box').hide()
    }
  },
  initTextareaAutoResize: function(){
    autosize($('textarea'));
  },
  init : function(){
    var self = this
    self.initTextareaAutoResize()
    $('#reply_content').keyup(function(){
        self.runPreview()
    });
    console.log('_topic_ inited');
  }
}