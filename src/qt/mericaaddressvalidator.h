// Copyright (c) 2011-2014 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef MERICA_QT_MERICAADDRESSVALIDATOR_H
#define MERICA_QT_MERICAADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class MERICAAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit MERICAAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const override;
};

/** MERICA address widget validator, checks for a valid merica address.
 */
class MERICAAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit MERICAAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const override;
};

#endif // MERICA_QT_MERICAADDRESSVALIDATOR_H
