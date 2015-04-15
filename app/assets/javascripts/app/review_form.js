App.addChild('ReviewForm', _.extend({
  el: 'form#review_form',

  events: {
    'blur input' : 'checkInput',
    'click #accept' : 'acceptTerms'
  },

  acceptTerms: function(){
    if(this.validate()){
      $('#payment').show();
      this.updateBacker();
    } else {
      return false;
    }
  },

  activate: function(){
    this.setupForm();
  },

  updateBacker: function(){
    var backer_data = {
      payer_name: this.$('#user_full_name').val(),
      payer_email: this.$('#user_email').val(),
      address_1: this.$('#user_address_1').val(),
      address_2: this.$('#user_address_2').val(),
      address_3: this.$('#user_address_3').val(),
      address_zip_code: this.$('#user_address_zip_code').val(),
      address_city: this.$('#user_address_city').val(),
      address_county: this.$('#user_address_county').val(),
      address_phone_number: this.$('#user_phone_number').val()
    }
    $.post(this.$el.data('update-info-path'), {
      _method: 'put',
      backer: backer_data
    });
  }
}, Skull.Form));
