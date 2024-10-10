import { Request, Response, NextFunction } from 'express';

// Middleware para converter BigInt em string nas respostas JSON
export const bigIntMiddleware = (req: Request, res: Response, next: NextFunction) => {
  const oldJson = res.json;

  res.json = function (data: any) {
    const dataStringified = JSON.stringify(data, (key, value) => 
      typeof value === 'bigint' ? value.toString() : value
    );
    return oldJson.call(this, JSON.parse(dataStringified));
  };

  next();
};
