<header class="d-flex align-items-center">
      <div class="container d-flex align-items-center justify-content-between">
            <a href="<?= env("SITE_URL") ?>" class="text-decoration-none">
                  <h3 class="text-white mb-0"><?= env("TITLE") ?></h3>
            </a>
            <div class="buttons-wrapper d-flex gap-3">
                  <?php if (isLoggedIn()): ?>
                        <?php if ($userRole == "admin"): ?>
                              <a href="<?= env("SITE_URL") ?>adminDashboard.php" class="btn btn-primary">لوحة التحكم </a>
                        <?php elseif ($userRole == 'local'): ?>
                              <a href="<?= env("SITE_URL") ?>localDashboard.php" class="btn btn-primary">لوحة التحكم </a>
                        <?php else: ?>
                              <a href="<?= env(" SITE_URL") ?>touristDashboard.php" class="btn btn-primary">لوحة التحكم </a>
                        <?php endif; ?>
                        <a href="<?= env("SITE_URL") ?>logout.php" class="btn btn-danger">تسجيل الخروج</a>
                  <?php else: ?>
                        <a href="<?= env("SITE_URL") ?>login.php" class="btn btn-success">تسجيل الدخول</a>
                        <a href="<?= env("SITE_URL") ?>register.php" class="btn btn-primary">انشاء حساب</a>
                  <?php endif; ?>
            </div>
      </div>
</header>