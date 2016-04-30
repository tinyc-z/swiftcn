// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
window._topic_ = 
{
  runPreview : function() {
    var replyContent = $("#body_original");
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
    /*
   * Use Ctrl + Enter for reply
   */
  initReplyOnPressKey: function() {
      $(document).keydown("#body_original", function(e)
      {
          if ((e.keyCode == 10 || e.keyCode == 13) && e.ctrlKey) {
              $(this).parents("form").submit();
              return false;
          }
      });
  },
  initAutocompleteAtUser: function() {
      var at_users = [],user;
      $users = $('.media-heading').find('a.author');
      for (var i = 0; i < $users.length; i++) {
          user = $users.eq(i).text().trim();
          if ($.inArray(user, at_users) == -1) {
              at_users.push(user);
          };
      };
      $('textarea').textcomplete([{
          mentions: at_users,
          match: /\B@(\w*)$/,
          search: function(term, callback) {
              callback($.map(this.mentions, function(mention) {
                  return mention.indexOf(term) === 0 ? mention : null;
              }));
          },
          index: 1,
          replace: function(mention) {
              return '@' + mention + ' ';
          }
      }], {
          appendTo: 'body'
      });
  },
  /**
 * lightbox
 */
  initLightBox: function(){
      $(document).delegate('.content-body img:not(.emoji)', 'click', function(event) {
          event.preventDefault();
          return $(this).ekkoLightbox({
              onShown: function() {
                  if (window.console) {
                      // return console.log('Checking our the events huh?');
                  }
              }
          });
      });
  },

  /**
   * Init post content preview
   */
  initEditorPreview: function() {
      var self = this;
      $("#body_original").focus(function(event) {
          $("#reply_notice").fadeIn(1500);
          $("#preview-box").fadeIn(1500);
          $("#preview-lable").fadeIn(1500);

          if (!$("#body_original").val()) {
              $("html, body").animate({ scrollTop: $(document).height()}, 1800);
          }
      });
      $('#body_original').keyup(function(){
          self.runPreview();
      });
  },
   /**
   * Local Storage
   */
  initLocalStorage: function() {
      var self = this;
      $("#body_original").focus(function(event) {

          // Topic Title ON Topic Creation View
          localforage.getItem('topic-title', function(err, value) {
              if ($('.topic_create #topic-title').val() == '' && !err) {
                  $('.topic_create #topic-title').val(value);
              };
          });
          $('.topic_create #topic-title').keyup(function(){
              localforage.setItem('topic-title', $(this).val());
          });

          // Topic Content ON Topic Creation View
          localforage.getItem('topic_create_content', function(err, value) {
              if ($('.topic_create #body_original').val() == '' && !err) {
                  $('.topic_create #body_original').val(value);
                  self.runPreview();
              }
          });
          $('.topic_create #body_original').keyup(function(){
              localforage.setItem('topic_create_content', $(this).val());
          });

          // Reply Content ON Topic Detail View
          localforage.getItem('body_original', function(err, value) {
              if ($('.topics-show #body_original').val() == '' && !err) {
                  $('.topics-show #body_original').val(value);
                  self.runPreview();
              }
          });
          $('.topics-show #body_original').keyup(function(){
              localforage.setItem('body_original', $(this).val());
          });
      })
    },

    initHeightLight: function(){
      // Prism.highlightAll();
      // hljs.initHighlightingOnLoad();
      $('pre code').each(function(i, block) {
          hljs.highlightBlock(block);
      });
    },

  init : function(){
    var self = this
    self.initTextareaAutoResize()
    self.initReplyOnPressKey()
    self.initAutocompleteAtUser()
    self.initLightBox()
    self.initLocalStorage()
    self.initEditorPreview()
    self.initHeightLight()
    $('#body_original').keyup(function(){
        self.runPreview()
    });

    webshim.polyfill('forms');

    log('_topic_ inited');
  }
}


function replyOne(username){
    replyContent = $("#body_original");
    oldContent = replyContent.val();
    prefix = "@" + username + " ";
    newContent = ''
    if(oldContent.length > 0){
        if (oldContent != prefix) {
            newContent = oldContent + "\n" + prefix;
        }
    } else {
        newContent = prefix
    }
    replyContent.focus();
    replyContent.val(newContent);
    moveEnd($("#body_original"));
}