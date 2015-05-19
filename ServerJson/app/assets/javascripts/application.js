// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require_tree .


J = {

    init: function () {
        J.session();
        J.event();
        J.tag();
        J.genre();
        J.comments();
        J.favorite();
        J.testUsers();
        J.testDailyPost();
        J.testRegPost();
    },


    //'soc':{'type':'vk', 'id':'123123', 'access_token':'$2a$10$TlxTfAg8QmFMzuY97EiTJuOk30Tz.xLcokXuGeTBHxHp.F2IqNyY2'},
    testRegPost: function () {
        API.postReg({'character_id':0, 'character':{'character_arr':'1, 2'},
        'registration':{'city':1, 'email':'zhulvern-94@mail.ru', 'login':'gdg8', 'password':'111111', 'password_confirmation':'111111'}},
        function(code) {
            alert(code.reg);
        } ,
        function (code) {
            alert(code);
        }
        );
    },


    testDailyPost: function () {
        //set (and create if not exist)
        //J.setDailyPost();
    },


    setDailyPost: function () {
        API.setDailyPost({'context': 'test context daily post'},
            function (code) {
                alert(code.save_success);
            },
            function (code) {
                alert(code);
            });
    },


    testUsers: function () {
        //J.editPassword();
        //J.getCity();
        //J.setCity();
        //J.getCharacterName();
        //J.setCharacterName();
        //J.deleteFavoriteEvent();
        //J.setLogin();
        //J.addAdminUserByPk();
        //J.deleteAdminUserByPk();

    },

    deleteAdminUserByPk: function () {
        API.deleteAdminUserByPk({'user_id': 2},
            function (code) {
                alert(code.save_success);
            },
            function (code) {
                alert(code);
            });
    },

    addAdminUserByPk: function () {
        API.addAdminUserByPk({'user_id': 2},
            function (code) {
                alert(code.save_success);
            },
            function (code) {
                alert(code);
            });
    },

    setLogin: function () {
        API.setLogin({'user_id': 2, 'login': 'gdg7'},
            function (code) {
                alert(code.save_success);
            },
            function (code) {
                alert(code);
            });
    },


    deleteFavoriteEvent: function () {
        API.deleteFavoriteEvent({'id': 24},
            function (code) {
                alert(code.delete_success);
            },
            function (code) {
                alert(code);
            });
    },

    setCharacterName: function () {
        API.setCharacterName({'user_id': 2, 'characterName': 'milk'},
            function (code) {
                alert(code.save_success);
            },
            function (code) {
                alert(code);
            });
    },


    getCharacterName: function () {
        API.getCharacterName({'user_id': 2},
            function (code) {
                alert(code.characterName);
            },
            function (code) {
                alert(code);
            });
    },

    setCity: function () {
        API.setCityForUserId({'user_id': 2, 'city': 'Moscow'},
            function (code) {
                alert(code.save_success);
            },
            function (code) {
                alert(code);
            });
    },

    getCity: function () {
        API.getCityForUserId({'user_id': 2},
            function (code) {
                alert(code.city);
            },
            function (code) {
                alert(code);
            });
    },

    editPassword: function () {
        API.EditPasswordForUserIdWithOldPassword({'user_id': 2, 'old_password': '123456', 'new_password': '123456'},
            function (code) {
                alert(code.save_success);
            },
            function (code) {
                alert(code);
            });

    },


    session: function () {
        //registration
        $(document).off("click", ".sys-reg-user");
        $(document).on("click", ".sys-reg-user", function () {
            var form = $(document).find("form");
            API.registration(form.serialize(), function (code) {
                alert(code.reg);
            }, function (code) {
                alert(code);
            });

        });
    },

    event: function () {
        // add event
        $(document).off("click", ".sys-add-event");
        $(document).on("click", ".sys-add-event", function () {
            var form = $(document).find("form");
            API.addEvent(form.serialize(), function (code) {
                alert(code.save_success);
            }, function (code) {
                alert(code);
            });
        });

        //edit event
        $(document).off("click", ".sys-edit-event");
        $(document).on("click", ".sys-edit-event", function () {
            var form = $(document).find("form");
            API.editEvent($(document).find("input[id=event_id]").val(), form.serialize(), function (code) {
                alert(code.save_success);
            }, function (code) {
                alert(code);
            });
        });
    },

    tag: function () {
        // add tag
        $(document).off("click", ".sys-add-tag");
        $(document).on("click", ".sys-add-tag", function () {
            var form = $(document).find("form");
            API.addTag(form.serialize(), function (code) {
                alert(code.save_success);
            }, function (code) {
                alert(code);
            });
        });
    },

    genre: function () {
        // add genre
        $(document).off("click", ".sys-add-genre_tag");
        $(document).on("click", ".sys-add-genre_tag", function () {
            var form = $(document).find("form");
            API.addGenre(form.serialize(), function (code) {
                alert(code.save_success);
            }, function (code) {
                alert(code);
            });
        });
    },

    comments: function () {
        // add comments
        $(document).off("click", ".sys-add-comment");
        $(document).on("click", ".sys-add-comment", function () {
            var form = $(document).find("form");
            API.addComment(form.serialize(), function (code) {
                alert(code.save_success);
            }, function (code) {
                alert(code);
            });
        });
    },

    favorite: function () {
        $(document).off("click", ".sys-add-favorite");
        $(document).on("click", ".sys-add-favorite", function () {
            var form = $(document).find("form");
            API.addFavorite(form.serialize(), function (code) {
                alert(code.save_success);
            }, function (code) {
                alert(code);
            });
        });
    }
};


$(document).ready(function () {
    J.init();
});
