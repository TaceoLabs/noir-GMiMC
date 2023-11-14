use crate::bn254::consts;
use crate::decrypt;
use crate::GmimcConfig;

#[field(bn254)]
pub fn x5_2(mut x: [Field; 2], k: Field) -> [Field; 2] {
    decrypt(consts::x5_2_config(), x, k)
}

#[field(bn254)]
pub fn x5_3(mut x: [Field; 3], k: Field) -> [Field; 3] {
    decrypt(consts::x5_3_config(), x, k)
}

#[field(bn254)]
pub fn x5_4(mut x: [Field; 4], k: Field) -> [Field; 4] {
    decrypt(consts::x5_4_config(), x, k)
}

#[field(bn254)]
pub fn x5_5(mut x: [Field; 5], k: Field) -> [Field; 5] {
    decrypt(consts::x5_5_config(), x, k)
}

#[field(bn254)]
pub fn x5_6(mut x: [Field; 6], k: Field) -> [Field; 6] {
    decrypt(consts::x5_6_config(), x, k)
}

#[field(bn254)]
pub fn x5_7(mut x: [Field; 7], k: Field) -> [Field; 7] {
    decrypt(consts::x5_7_config(), x, k)
}

#[field(bn254)]
pub fn x5_8(mut x: [Field; 8], k: Field) -> [Field; 8] {
    decrypt(consts::x5_8_config(), x, k)
}

#[field(bn254)]
pub fn x5_9(mut x: [Field; 9], k: Field) -> [Field; 9] {
    decrypt(consts::x5_9_config(), x, k)
}

#[field(bn254)]
pub fn x5_10(mut x: [Field; 10], k: Field) -> [Field; 10] {
    decrypt(consts::x5_10_config(), x, k)
}

#[field(bn254)]
pub fn x5_11(mut x: [Field; 11], k: Field) -> [Field; 11] {
    decrypt(consts::x5_11_config(), x, k)
}

#[field(bn254)]
pub fn x5_12(mut x: [Field; 12], k: Field) -> [Field; 12] {
    decrypt(consts::x5_12_config(), x, k)
}

#[field(bn254)]
pub fn x5_13(mut x: [Field; 13], k: Field) -> [Field; 13] {
    decrypt(consts::x5_13_config(), x, k)
}

#[field(bn254)]
pub fn x5_14(mut x: [Field; 14], k: Field) -> [Field; 14] {
    decrypt(consts::x5_14_config(), x, k)
}

#[field(bn254)]
pub fn x5_15(mut x: [Field; 15], k: Field) -> [Field; 15] {
    decrypt(consts::x5_15_config(), x, k)
}

#[field(bn254)]
pub fn x5_16(mut x: [Field; 16], k: Field) -> [Field; 16] {
    decrypt(consts::x5_16_config(), x, k)
}
