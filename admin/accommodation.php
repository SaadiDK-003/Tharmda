<?php
require_once '../core/database.php';
if ($userRole != 'admin') {
    header('Location: index.php');
}
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?= env("TITLE") ?> | لوحة تحكم اماكن إلاقامات المشرف</title>
    <?php include_once "../includes/external_css.php"; ?>
</head>

<body id="adminPlacesDashboard">
    <?php include_once "../includes/header.php"; ?>
    <main>
        <div class="container my-5">
            <div class="row">
                <div class="col-12">
                    <div class="btn_wrapper d-flex justify-content-center align-items-center gap-2">
                        <a href="../addAccommodation.php" class="btn btn-primary">إضافة أماكن الإقامة</a>
                        <a href="../adminDashboard.php" class="btn btn-danger">الرجوع</a>
                    </div>
                </div>
            </div>
            <div class="row mt-4">
                <div class="col-12 mx-auto">
                    <table id="acc-table"
                        class="table table-bordered table-striped table-responsive text-center align-middle">
                        <thead>
                            <tr>
                                <th class="text-center">اسم المدينة</th>
                                <th class="text-center">النوع</th>
                                <th class="text-center">الموقع</th>
                                <th class="text-center">الخدمات</th>
                                <th class="text-center">الصور</th>
                                <th class="text-center">الحالة</th>
                                <th class="text-center">الاجراء</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php
                            $acc_Q = $db->query("CALL `get_acc_admin`()");
                            if ($acc_Q->num_rows > 0):
                                while ($acc = $acc_Q->fetch_object()):
                                    $status = $acc->status;
                                    $images = explode(',', $acc->accommodation_image);
                                    $imagesCount = count($images);
                                    ?>

                                    <tr>
                                        <td class="text-center"><?= $acc->city_name ?></td>
                                        <td class="text-center"><?= $acc->type ?></td>
                                        <td class="text-center"><?= $acc->location ?></td>
                                        <td class="text-center"><?= $acc->services ?></td>
                                        <?php if ($imagesCount == 1): ?>
                                            <td class="text-center">
                                                <img src="<?= env("SITE_URL") ?><?= $images[0] ?>" width="80" height="80"
                                                    class="d-block mx-auto rounded" alt="place_<?= $acc->acc_id ?>">
                                            </td>
                                        <?php else: ?>
                                            <td class="img text-center">
                                                <?php foreach ($images as $image): ?>
                                                    <img src="<?= env("SITE_URL") ?><?= $image ?>" width="80" height="80"
                                                        class="d-block mx-auto rounded" alt="place_<?= $acc->acc_id ?>">
                                                <?php endforeach; ?>
                                            </td>
                                        <?php endif; ?>
                                        <td class="text-center">
                                            <?= $status == '0' ? '<span class="btn btn-sm btn-warning">Pending</span>' : '<span class="btn btn-sm btn-success">Active</span>' ?>
                                        </td>
                                        <td class="text-center"><a href="#!" data-id="<?= $acc->acc_id ?>"
                                                data-bs-toggle="modal" data-bs-target="#placeModal" data-msg="Accommodation"
                                                class="btn btn-sm btn-primary btn-get-place"><i class="fas fa-edit"></i></a>
                                            <a href="#!" data-id="<?= $acc->acc_id ?>" data-table="accommodation"
                                                data-msg="Accommodation" class="btn btn-sm btn-danger btn-del"><i
                                                    class="fas fa-trash"></i></a>
                                        </td>
                                    </tr>

                                    <?php
                                endwhile;
                            endif;
                            $acc_Q->close();
                            $db->next_result();
                            ?>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </main>
    <?php include_once "../includes/footer.php"; ?>
    <?php include_once "../includes/external_js.php"; ?>


    <!-- Modal -->
    <div class="modal fade" id="placeModal" tabindex="-1" aria-labelledby="placeLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-sm">
            <div class="modal-content">
                <form id="updateAccStatus">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="placeLabel">تحديث الإقامة</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-12">
                                <div class="form-group">
                                    <label for="status" class="form-label">الحالة</label>
                                    <select type="text" name="status" id="status" class="form-select" required>
                                        <option value="" selected hidden>اختيار الحالة </option>
                                        <option value="0">غير نشط</option>
                                        <option value="1">نشط</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">اغلاق</button>
                        <input type="hidden" name="acc_id">
                        <input type="hidden" name="msg">
                        <button type="submit" class="btn btn-primary">حفظ التغيرات</button>
                    </div>
                </form>
            </div>
        </div>
    </div>


    <script>
        $(document).ready(function () {
            new DataTable("#acc-table", {
                ordering: false,
                pageLength: 5,
                layout: {
                    topStart: null
                }
            });


            $(document).on("click", ".btn-get-place", function (e) {
                e.preventDefault();
                let id = $(this).data("id");
                let msg = $(this).data("msg");
                $("input[name='acc_id']").val(id);
                $("input[name='msg']").val(msg);
            });

            // Update Place Status
            $("#updateAccStatus").on("submit", function (e) {
                e.preventDefault();
                let formData = $(this).serialize();

                $.ajax({
                    url: "../ajax/acc_status.php",
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
                    url: "../ajax/delete.php",
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