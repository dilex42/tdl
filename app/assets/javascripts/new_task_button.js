$( document ).on( 'keyup', '.new_task', function () {
        var id = parseInt(this.id.replace('new_task_', ''));
         if ($("#new_task_"+id).val() !== "") {
            $("#new_btn_"+id).removeAttr('disabled');
        } else {
            $("#new_btn_"+id).attr('disabled', 'true');
        }
    });
