CREATE MIGRATION m12ogdtnwwp2gkj5guqpjdh7xkncrt4zkowtz6gzhzb6usd3hmdyeq
    ONTO m1bkchslsgwx4do2szxtlrkevqfsakkhze6wv5b4b52f2cmnkc6gaq
{
  CREATE GLOBAL default::base_sendpay_address -> std::str {
      SET default := '0x7CE90eF0f63c786C627576cFFa6d942fB55Ae385';
      CREATE ANNOTATION std::description := 'An ethereum address that will receive the confirmation tx';
  };
  ALTER TYPE default::Session {
      ALTER PROPERTY confirmation_address {
          SET default := (GLOBAL default::base_sendpay_address);
      };
  };
};
