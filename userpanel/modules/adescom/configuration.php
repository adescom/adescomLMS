<?php

$USERPANEL->AddModule(
    trans('Billing panel'),
    'adescom',
    trans('Login to Adescom user panel'),
    80,
    trans('Adescom module'),
    array()
);

$finances_manager = new AdescomFinanceManager(
    $LMS->getDb(), $LMS->getAuth(), $LMS->getCache(), $LMS->getSyslog()
);
$finances_manager->setUserpanel();
$LMS->setFinanaceManager($finances_manager);
