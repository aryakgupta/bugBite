<?php
require dirname(__FILE__).'/../../../api/apiLayer.php';

$objConfig = new apiLayer();

return array (
  'stats_api' => 'Server',
  'slabs_api' => 'Server',
  'items_api' => 'Server',
  'get_api' => 'Server',
  'set_api' => 'Server',
  'delete_api' => 'Server',
  'flush_all_api' => 'Server',
  'connection_timeout' => '1',
  'max_item_dump' => '100',
  'refresh_rate' => 5,
  'memory_alert' => '80',
  'hit_rate_alert' => '90',
  'eviction_alert' => '0',
  'file_path' => 'Temp/',
  'servers' =>
  array (
    'Default' =>
    array (
      '172.31.22.159:11211' =>
      array (
        'hostname' => $objConfig->cacheServer,
        'port' => $objConfig->cachePort,
      ),
    ),
  ),
);
