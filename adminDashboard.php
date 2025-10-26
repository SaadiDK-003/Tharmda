<?php
require_once 'core/database.php';
if ($userRole != 'admin') {
    header('Location: index.php');
}
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?= env("TITLE") ?> | لوحة تحكم المشرف</title>
    <?php include_once "includes/external_css.php"; ?>
</head>

<body id="adminDashboard">
    <?php include_once "includes/header.php"; ?>
    <main>
        <div class="container my-5">
            <div class="row">
                <div class="col-12">
                    <div class="btn_wrapper d-flex justify-content-center gap-2">
                        <a href="./admin/places.php" class="btn btn-primary">تحديث حالة الأماكن</a>
                        <a href="./admin/accommodation.php" class="btn btn-secondary">تحديث حالة أماكن الإقامة</a>
                        <a href="./admin/events.php" class="btn btn-warning">تحديث حالة الأحداث</a>
                    </div>
                </div>
            </div>
            <form id="add_city_form" class="city_form my-4">
                <div class="row">
                    <div class="col-12 col-md-3 mx-auto">
                        <div class="row">
                            <div class="col-12 mx-auto mb-3">
                                <div class="form-group">
                                    <label for="city_name" class="form-label">اسم المدينة </label>
                                    <input type="text" name="city_name" id="city_name" class="form-control" required>
                                </div>
                            </div>
                            <div class="col-12 mb-3">
                                <div class="form-group d-flex justify-content-end">
                                    <input type="hidden" name="city_id">
                                    <button type="submit" class="btn btn-success"> اضافة مدينة</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
            <div class="row">
                <div class="col-12 col-md-5 mx-auto">
                    <table id="cities"
                        class="table table-bordered table-striped table-responsive text-center align-middle">
                        <thead>
                            <tr>
                                <th class="text-center">اسم المدينة</th>
                                <th class="text-center">الاجراء</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php
                            $cities_Q = $db->query("CALL `get_cities`()");
                            if ($cities_Q->num_rows > 0):
                                while ($city = $cities_Q->fetch_object()): ?>

                                    <tr>
                                        <td><?= $city->city_name ?></td>
                                        <td>
                                            <a href="#!" data-id="<?= $city->id ?>" data-city="<?= $city->city_name ?>"
                                                class="btn btn-sm btn-primary btn-upd-city"><i class="fas fa-pencil"></i></a>
                                            <a href="#!" data-id="<?= $city->id ?>" data-table="cities" data-msg="City"
                                                class="btn btn-sm btn-danger btn-del"><i class="fas fa-trash"></i></a>
                                        </td>
                                    </tr>

                                    <?php
                                endwhile;
                            endif;
                            $cities_Q->close();
                            $db->next_result();
                            ?>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="row mt-4">
                <div class="col-12 text-center">
                    <a href="./admin_app.php" class="btn btn-primary btn-sm">التطبيقات</a>
                    <a href="./admin_place_types.php" class="btn btn-secondary btn-sm">أنواع الأماكن</a>
                    <a href="./admin_acc_types.php" class="btn btn-warning btn-sm">أنواع الإقامة</a>
                    <a href="./admin_all_users.php" class="btn btn-info btn-sm">كل المستخدمين</a>
                </div>
            </div>
        </div>
    </main>
    <?php include_once "includes/footer.php"; ?>
    <?php include_once "includes/external_js.php"; ?>

    <script>
        $(document).ready(function () {
            new DataTable("#cities", {
                info: false,
                ordering: false,
                pageLength: 5,
                layout: {
                    topStart: null
                }
            });
            // Add City
            $("#add_city_form").on("submit", function (e) {
                e.preventDefault();
                let formData = $(this).serialize();

                $.ajax({
                    url: "ajax/city.php",
                    method: "post",
                    data: formData,
                    success: function (response) {
                        let res = JSON.parse(response);
                        if (res.status == "success") {
                            $("#ToastSuccess").addClass("fade show");
                            $("#ToastSuccess .toast-body").html(res.msg);
                            setTimeout(() => {
                                window.location.reload();
                            }, 2000);
                        } else {
                            $("#ToastDanger").addClass("fade show");
                            $("#ToastDanger .toast-body").html(res.msg);
                        }
                    }
                });
            });


            $(document).on("click", ".btn-upd-city", function (e) {
                e.preventDefault();
                let id = $(this).data("id");
                let city = $(this).data("city");
                $(".city_form").attr("id", "upd_city_form");
                $(".city_form").find("#city_name").attr("name", "city_update").val(city);
                $("input[name='city_id']").val(id);
                $(".city_form").find("button").text("Update");
            });

            // Update City
            $("#upd_city_form").on("submit", function (e) {
                e.preventDefault();
                let formData = $(this).serialize();

                $.ajax({
                    url: "ajax/city.php",
                    method: "post",
                    data: formData,
                    success: function (response) {
                        let res = JSON.parse(response);
                        if (res.status == "success") {
                            $("#ToastSuccess").addClass("fade show");
                            $("#ToastSuccess .toast-body").html(res.msg);
                            setTimeout(() => {
                                window.location.reload();
                            }, 2000);
                        } else {
                            $("#ToastDanger").addClass("fade show");
                            $("#ToastDanger .toast-body").html(res.msg);
                        }
                    }
                });
            });


            // Delete
            $(document).on("click", ".btn-del", function (e) {
                e.preventDefault();
                let id = $(this).data('id');
                let table = $(this).data('table');
                let msg = $(this).data('msg');

                $.ajax({
                    url: "ajax/delete.php",
                    method: "post",
                    data: {
                        del_id: id,
                        del_table: table,
                        msg: msg
                    },
                    success: function (response) {
                        console.log(response);

                        let res = JSON.parse(response);
                        $('#ToastDanger').addClass('fade show');
                        $("#ToastDanger .toast-body").html(res.msg);
                        setTimeout(() => {
                            window.location.reload();
                        }, 1800);
                    }
                });
            });

        });
    </script>
</body>

</html>