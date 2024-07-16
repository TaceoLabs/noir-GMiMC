use dep::std::field::modulus_num_bits;

/// Instantiations of GMiMC for prime field of the same order as BN254
mod bn254;

struct GmimcConfig<R> {
    alpha: Field, // S-box power; depends on the underlying field
    arc: [Field; R], // round constants
}

pub fn config<R>(alpha: Field, arc: [Field; R]) -> GmimcConfig<R> {
    GmimcConfig { alpha, arc }
}

fn round<T>(mut state: [Field; T], key: Field, alpha: Field, arc: Field) -> [Field; T] {
    let sum = state[0] + key + arc;
    let power = sum.pow_32(alpha);
    for i in 1..T {
        state[i] += power;
    }
    state
}

fn dec_round<T>(mut state: [Field; T], key: Field, alpha: Field, arc: Field) -> [Field; T] {
    let sum = state[0] + key + arc;
    let power = sum.pow_32(alpha);
    for i in 1..T {
        state[i] -= power;
    }
    state
}

fn feistel_shift<T>(mut state: [Field; T]) -> [Field; T] {
    let tmp = state[T - 1];
    for i in 1..T {
        state[T - i] = state[T - i - 1];
    }
    state[0] = tmp;
    state
}

fn inv_feistel_shift<T>(mut state: [Field; T]) -> [Field; T] {
    let tmp = state[0];
    for i in 0..T - 1 {
        state[i] = state[i + 1];
    }
    state[T - 1] = tmp;
    state
}

// General GMiMC block cipher
pub fn encrypt<T, R>(gmimc_conf: GmimcConfig<R>, mut x: [Field; T], k: Field) -> [Field; T] {
    // otherwise key is too small
    assert(modulus_num_bits() as u16 >= 128);

    let GmimcConfig {alpha, arc} = gmimc_conf;

    for r in 0..R - 1 {
        x = round(x, k, alpha, arc[r]);
        x = feistel_shift(x);
    }
    x = round(x, k, alpha, arc[R - 1]);
    x
}

pub fn decrypt<T, R>(gmimc_conf: GmimcConfig<R>, mut x: [Field; T], k: Field) -> [Field; T] {
    // otherwise key is too small
    assert(modulus_num_bits() as u16 >= 128);

    let GmimcConfig {alpha, arc} = gmimc_conf;

    for r in 1..R {
        x = dec_round(x, k, alpha, arc[R - r]);
        x = inv_feistel_shift(x);
    }
    x = dec_round(x, k, alpha, arc[0]);
    x
}

#[test]
fn test_enc_x5_02() {
    let x = [8654, 872364];
    let k = 1246;
    let cipher = bn254::enc::x5_2(x, k);
    let plain = bn254::dec::x5_2(cipher, k);
    assert(x == plain);
}

#[test]
fn test_enc_x5_03() {
    let x = [8654, 872364, 872634];
    let k = 1246;
    let cipher = bn254::enc::x5_3(x, k);
    let plain = bn254::dec::x5_3(cipher, k);
    assert(x == plain);
}

#[test]
fn test_enc_x5_04() {
    let x = [8654, 872364, 872634, 6723];
    let k = 1246;
    let cipher = bn254::enc::x5_4(x, k);
    let plain = bn254::dec::x5_4(cipher, k);
    assert(x == plain);
}

#[test]
fn test_enc_x5_05() {
    let x = [8654, 872364, 872634, 6723, 98234];
    let k = 1246;
    let cipher = bn254::enc::x5_5(x, k);
    let plain = bn254::dec::x5_5(cipher, k);
    assert(x == plain);
}

#[test]
fn test_enc_x5_06() {
    let x = [8654, 872364, 872634, 6723, 98234, 72394];
    let k = 1246;
    let cipher = bn254::enc::x5_6(x, k);
    let plain = bn254::dec::x5_6(cipher, k);
    assert(x == plain);
}

#[test]
fn test_enc_x5_07() {
    let x = [8654, 872364, 872634, 6723, 98234, 72394, 983745];
    let k = 1246;
    let cipher = bn254::enc::x5_7(x, k);
    let plain = bn254::dec::x5_7(cipher, k);
    assert(x == plain);
}

#[test]
fn test_enc_x5_08() {
    let x = [8654, 872364, 872634, 6723, 98234, 72394, 983745, 3289075];
    let k = 1246;
    let cipher = bn254::enc::x5_8(x, k);
    let plain = bn254::dec::x5_8(cipher, k);
    assert(x == plain);
}

#[test]
fn test_enc_x5_09() {
    let x = [8654, 872364, 872634, 6723, 98234, 72394, 983745, 3289075, 283974];
    let k = 1246;
    let cipher = bn254::enc::x5_9(x, k);
    let plain = bn254::dec::x5_9(cipher, k);
    assert(x == plain);
}

#[test]
fn test_enc_x5_10() {
    let x = [8654, 872364, 872634, 6723, 98234, 72394, 983745, 3289075, 283974, 2180734];
    let k = 1246;
    let cipher = bn254::enc::x5_10(x, k);
    let plain = bn254::dec::x5_10(cipher, k);
    assert(x == plain);
}

#[test]
fn test_enc_x5_11() {
    let x = [8654, 872364, 872634, 6723, 98234, 72394, 983745, 3289075, 283974, 2180734, 64];
    let k = 1246;
    let cipher = bn254::enc::x5_11(x, k);
    let plain = bn254::dec::x5_11(cipher, k);
    assert(x == plain);
}

#[test]
fn test_enc_x5_12() {
    let x = [8654, 872364, 872634, 6723, 98234, 72394, 983745, 3289075, 283974, 2180734, 64, 1212];
    let k = 1246;
    let cipher = bn254::enc::x5_12(x, k);
    let plain = bn254::dec::x5_12(cipher, k);
    assert(x == plain);
}

#[test]
fn test_enc_x5_13() {
    let x = [8654, 872364, 872634, 6723, 98234, 72394, 983745, 3289075, 283974, 2180734, 64, 1212, 7893];
    let k = 1246;
    let cipher = bn254::enc::x5_13(x, k);
    let plain = bn254::dec::x5_13(cipher, k);
    assert(x == plain);
}

#[test]
fn test_enc_x5_14() {
    let x = [8654, 872364, 872634, 6723, 98234, 72394, 983745, 3289075, 283974, 2180734, 64, 1212, 7893, 4536];
    let k = 1246;
    let cipher = bn254::enc::x5_14(x, k);
    let plain = bn254::dec::x5_14(cipher, k);
    assert(x == plain);
}

#[test]
fn test_enc_x5_15() {
    let x = [
        8654, 872364, 872634, 6723, 98234, 72394, 983745, 3289075, 283974, 2180734, 64, 1212, 7893, 4536, 23
    ];
    let k = 1246;
    let cipher = bn254::enc::x5_15(x, k);
    let plain = bn254::dec::x5_15(cipher, k);
    assert(x == plain);
}

#[test]
fn test_enc_x5_16() {
    let x = [
        8654, 872364, 872634, 6723, 98234, 72394, 983745, 3289075, 283974, 2180734, 64, 1212, 7893, 4536, 23, 53
    ];
    let k = 1246;
    let cipher = bn254::enc::x5_16(x, k);
    let plain = bn254::dec::x5_16(cipher, k);
    assert(x == plain);
}
