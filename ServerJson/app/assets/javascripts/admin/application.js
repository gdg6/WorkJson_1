

Admin = {


    init: function ()
    {
        Admin.admins();
        Admin.events();
    },


    admins: function()
    {
        $('.sys-admin-delete').on('click',
            function(admin) {
                Admin.delete_admin($(this).attr('value'),

                function(code) {
                    if(code.success == 'ok') {
                        $(this).parent().parent().parent().hide();
                    }
                },
                function(code) {
                    if(code.success == 'ok') { //wtf?
                        $(this).parent().parent().parent().hide();
                    }
                })
            }
        );
    },

    events: function() {
        
    },

    delete_admin: function(id, callback, err) {
        Admin.del('/admin/admins/'+id, {}, callback, err);
    },

    //========== AJAX ===========

    del: function (url, params, callback, err) {
        $.ajax({
            type: "DELETE",
            dataType: "json",
            url: url,
            data: params,
            time: 30000,
            success: callback,
            error: err
        });
    }, 

    post: function (url, params, callback, err) {
        $.ajax({
            type: "DELETE",
            dataType: "json",
            url: url,
            data: params,
            time: 30000,
            success: callback,
            error: err
        });
    }


};

$(document).ready(function () {
    Admin.init();
});
