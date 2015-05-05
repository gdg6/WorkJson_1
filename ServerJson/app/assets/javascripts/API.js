

API = {

    post: function(url, params, callback, err) {
        $.ajax({
            type: "POST",
            url:url,
            date: params,
            time: 30000,
            success: callback,
            error: err
        });
    },

    get: function(url, params, callback, err) {
        $.ajax({
            type: "GET",
            url:url,
            date: params,
            time: 30000,
            success: callback,
            error: err
        });
    }

};