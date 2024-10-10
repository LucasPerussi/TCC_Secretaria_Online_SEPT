
const crypto = require('crypto');

export const codeGenerator = async (length: number) => {
    var chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    var code = '';
    for (var i = 0; i < length; i++) {
        code += chars.charAt(Math.floor(Math.random() * chars.length));
    }
    return code;
};

export const numberGenerator = async (length: number) => {
    var chars = '0123456789';
    var code = '';
    for (var i = 0; i < length; i++) {
        code += chars.charAt(Math.floor(Math.random() * chars.length));
    }
    return code;
};

export const HashMD5Generator = async (data: string) => {
    const hash = crypto.createHash('md5');
    hash.update(data);
    return hash.digest('hex');
  }
