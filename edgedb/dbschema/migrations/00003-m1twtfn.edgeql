CREATE MIGRATION m1twtfngumxghaebesx3aqs25k33whdtal5pbbdvv5bg56xtxdf2ha
    ONTO m13mehgioc5mmiofsyfa7cxe2hkilocb3oc32jncet3nqw2dz3x44a
{
  ALTER GLOBAL default::base_sendpay_address {
      DROP ANNOTATION std::description;
  };
  ALTER TYPE default::Session {
      ALTER PROPERTY confirmation_address {
          RESET default;
      };
      ALTER PROPERTY confirmation_amount {
          SET default := 0n;
      };
  };
  DROP GLOBAL default::base_sendpay_address;
};
