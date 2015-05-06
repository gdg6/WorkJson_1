

API = {


    registration : function(params, callback, err) {
      API.post("/registration.json", params,  callback, err);
    },

    addEvent : function(params, callback, err) {
      API.post("/events.json", params, callback, err);
    },

    deleteEvent : function(id, callback, err) {
        API.del("/events/" + id + ".json", callback, err);
    },

    addTag : function(params, callback, err) {
      API.post("/tags.json", params, callback, err);
    },

    addGenre : function(params, callback, err) {
        API.post("/genre_tags.json", params, callback, err);
    },

    addComment : function(params, callback, err) {
        API.post("/comments.json", params, callback, err);
    },


    //=====================  AJAX  ============================
    put: function(url, params, callback, err) {
        $.ajax({
            type: "PUT",
            dataType: "json",
            url:url,
            data: params,
            time: 30000,
            success: callback,
            error: err
        });
    },

    del: function(url, params, callback, err) {
        $.ajax({
            type: "DELETE",
            dataType: "json",
            url:url,
            data: params,
            time: 30000,
            success: callback,
            error: err
        });
    },

    post: function(url, params, callback, err) {
        $.ajax({
            type: "POST",
            dataType: "json",
            url:url,
            data: params,
            time: 30000,
            success: callback,
            error: err
        });
    },

    get: function(url, params, callback, err) {
        $.ajax({
            type: "GET",
            dataType: "json",
            url:url,
            data: params,
            time: 30000,
            success: callback,
            error: err
        });
    }

};