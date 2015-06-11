API = {


    //=================  Test request =========================
    registration: function (params, callback, err) {
        API.post("/registration.json", params, callback, err);
    },

    updateDailyPost: function (params, callback, err) {
        API.post("/setDailyPost.json", params, callback, err);
    },

    updateCharacter: function (params, callback, err) {
        API.post("/setCharacter.json", params, callback, err);
    },

    addEvent: function (params, callback, err) {
        API.post("/events.json", params, callback, err);
    },

    editEvent: function (id, params, callback, err) {
        API.put("/events/" + id + ".json", params, callback, err);
    },


    deleteEvent: function (id, callback, err) {
        API.del("/events/" + id + ".json", callback, err);
    },

    addTag: function (params, callback, err) {
        API.post("/tags.json", params, callback, err);
    },

    addGenre: function (params, callback, err) {
        API.post("/genre_tags.json", params, callback, err);
    },

    addComment: function (params, callback, err) {
        API.post("/comments.json", params, callback, err);
    },

    addFavorite: function (params, callback, err) {
        API.post("/addFavoriteEvent.json", params, callback, err);
    },


    EditPasswordForUserIdWithOldPassword: function (params, callback, err) {
        API.post("/EditPasswordForUserId.json", params, callback, err);
    },

    getCityForUserId: function (params, callback, err) {
        API.post("/getCityForUserId.json", params, callback, err);
    },

    setCityForUserId: function (params, callback, err) {
        API.post("/setCityForUserId.json", params, callback, err);
    },

    getCharacterName: function (params, callback, err) {
        API.post("/getCharacterName.json", params, callback, err);
    },


    setCharacterName: function (params, callback, err) {
        API.post("/setCharacterName.json", params, callback, err);
    },

    deleteFavoriteEvent: function (params, callback, err) {
        API.post("/deleteFavoriteEvent.json", params, callback, err);
    },

    setLogin: function (params, callback, err) {
        API.post("/setLogin.json", params, callback, err);
    },


    addAdminUserByPk: function (params, callback, err) {
        API.post("/addAdminByPK.json", params, callback, err);
    },

    deleteAdminUserByPk: function (params, callback, err) {
        API.post("/deleteAdminByPK.json", params, callback, err);
    },

    setDailyPost: function (params, callback, err) {
        API.post("/setDailyPost.json", params, callback, err);
    },

    postReg: function (params, callback, err) {
        API.post("/registration.json", params, callback, err);
    },


    //=====================  AJAX  ============================
    put: function (url, params, callback, err) {
        $.ajax({
            type: "PUT",
            dataType: "json",
            url: url,
            data: params,
            time: 30000,
            success: callback,
            error: err
        });
    },

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
            type: "POST",
            dataType: "json",
            url: url,
            data: params,
            time: 30000,
            success: callback,
            error: err
        });
    },

    get: function (url, params, callback, err) {
        $.ajax({
            type: "GET",
            dataType: "json",
            url: url,
            data: params,
            time: 30000,
            success: callback,
            error: err
        });
    }

};